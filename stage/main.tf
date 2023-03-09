locals {
  owner        = "ritesh"
  module_name  = "${var.env}-${local.owner}"
  ssh_key_pair = "ritesh-devops"
}

module "networking" {
  source          = "../modules/networking"
  env             = var.env
  cidr            = var.cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
}

module "compute" {
  source                 = "../modules/compute"
  env                    = var.env
  vpc                    = module.networking.vpc
  sg_pub_id              = module.networking.sg_pub_id
  sg_priv_id             = module.networking.sg_priv_id
  key_name               = local.ssh_key_pair
  frontend_instance_type = var.frontend_instance_type
  backend_instance_type  = var.backend_instance_type
  volume_size            = var.volume_size
}

module "security" {
  source = "../modules/security"

  vpc_id          = module.networking.vpc.vpc_id
  vpc_cidr_block  = var.cidr
  ssh_allowed_ips = var.ssh_allowed_ips
  env             = var.env
}