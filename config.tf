provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "infrastructure-terraform-dan"
    key    = "infrastructure"
    region = "us-east-2"
  }
}
