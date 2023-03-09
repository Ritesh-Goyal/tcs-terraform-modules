variable "env" {
  type    = string
  default = "stage"
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
  default = "10.2.0.0/16"
}

variable "private_subnets" {
  type    = list(any)
  default = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
}

variable "public_subnets" {
  type    = list(any)
  default = ["10.2.101.0/24", "10.2.102.0/24", "10.2.103.0/24"]
}