variable "env" {}

variable "vpc" {
  type    = any
  default = {}
}

variable "key_name" {
  type    = string
  default = null
}

variable "sg_pub_id" {
  type    = any
  default = {}
}

variable "sg_priv_id" {
  type    = any
  default = {}
}

variable "frontend_instance_type" {
  type    = string
  default = null
}

variable "backend_instance_type" {
  type    = string
  default = null
}

variable "volume_size" {
  type    = any
  default = 30
}