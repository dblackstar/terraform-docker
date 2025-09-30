terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }

  backend "s3" {
    bucket = "terraform-tfstate-millan"
    key    = "state/terraform.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
  region  = "us-east-2"
  profile = "Terraform"
}
