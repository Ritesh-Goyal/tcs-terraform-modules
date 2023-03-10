terraform {
  backend "s3" {
    bucket = "ritesh-aws-infrastructure-tfstate"
    key    = "stage/terraform.tfstate"
    region = "ap-south-1"
  }
}