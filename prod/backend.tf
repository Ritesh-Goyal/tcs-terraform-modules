terraform {
  backend "s3" {
    bucket = "ritesh-aws-infrastructure-tfstate"
    key    = "prod/terraform.tfstate"
    region = "ap-south-1"
  }
}