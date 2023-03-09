locals {
  owner       = "ritesh"
  module_name = "${var.env}-${local.owner}"
}

# An IAM role that we attach to the EC2 Instances in the cluster
resource "aws_iam_role" "ec2_instance" {
  name               = "${local.module_name}-ec2-instance"
  assume_role_policy = file("${path.module}/policies/ec2-instance.json")

  lifecycle { create_before_destroy = true }
}

resource "aws_iam_instance_profile" "ec2_instance" {
  name = "${local.module_name}-ec2-instance"
  role = aws_iam_role.ec2_instance.name
  lifecycle { create_before_destroy = true }
}

resource "aws_iam_role_policy" "ec2_instance_policy" {
  name   = "${local.module_name}-ec2-instance-policy"
  role   = aws_iam_role.ec2_instance.id
  policy = file("${path.module}/policies/ec2-instance-policy.json")

  lifecycle { create_before_destroy = true }
}

// Create aws_ami filter to pick up the ami available in your region
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "template_file" "default_user_data" {
  template = file("${path.module}/user-data/user-data.tpl")
}

// Configure the EC2 instance in a public subnet
module "frontend_instance" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  name                        = "${local.module_name}-frontend"
  ami                         = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  instance_type               = var.frontend_instance_type
  key_name                    = var.key_name
  user_data                   = data.template_file.default_user_data.rendered
  subnet_id                   = var.vpc.public_subnets[0]
  vpc_security_group_ids      = [var.sg_pub_id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance.name

  enable_volume_tags = true
  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = var.volume_size
    }
  ]
  tags = {
    "Name"        = "${local.module_name}-frontend"
    "environment" = "${var.env}"
  }
}

// Configure the EC2 instance in a private subnet
module "backend_server" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  name                        = "${local.module_name}-backend_server"
  ami                         = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = false
  instance_type               = var.backend_instance_type
  key_name                    = var.key_name
  user_data                   = data.template_file.default_user_data.rendered
  subnet_id                   = var.vpc.private_subnets[1]
  vpc_security_group_ids      = [var.sg_priv_id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance.name

  enable_volume_tags = true
  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = var.volume_size
    }
  ]

  tags = {
    "Name"        = "${local.module_name}-backend-server"
    "environment" = "${var.env}"
  }

}