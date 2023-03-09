variable "vpc_id" {
  description = "Id of VPC where security groups will live"
}

variable "vpc_cidr_block" {
  description = "The source CIDR block to allow traffic from"
}

variable "ssh_allowed_ips" {
  description = "IP address allowed to SSH to bastion instance"
}

variable "prod_cidrs" {
  type    = string
  default = "0.0.0.0/0"
}

variable "stage_cidrs" {
  type    = string
  default = "0.0.0.0/0"
}

variable "env" {
  type = string
}
