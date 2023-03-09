terraform {
  backend "s3" {
    bucket  = "core-infrastructure-devops-tfstate"
    key     = "stage/terraform.tfstate"
    region  = "us-west-1"
  }
}