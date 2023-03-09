variable "env" {}

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