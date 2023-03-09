terraform {
  backend "s3" {
    bucket  = "core-infrastructure-devops-tfstate"
    key     = "prod/terraform.tfstate"
    region  = "us-west-1"
  }
}