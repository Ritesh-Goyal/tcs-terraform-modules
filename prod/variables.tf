variable "env" {
  type    = string
  default = "prod"
}

variable "region" {
  description = "AWS region"
  default     = "us-west-1"
  type        = string
}

variable "frontend_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "backend_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ssh_key_pair" {
  type    = string
  default = ""
}

variable "volume_size" {
  type    = any
  default = 20
}

variable "ssh_allowed_ips" {
  type    = string
  default = "0.0.0.0/0"
}

variable "cidr" {
  type    = string
  default = "10.1.0.0/16"
}

variable "private_subnets" {
  type    = list(any)
  default = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
}

variable "public_subnets" {
  type    = list(any)
  default = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
}