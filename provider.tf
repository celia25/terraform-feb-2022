terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }
backend "s3" {
    bucket = "terraform-s3-backend-2022"
    key = "Celia/terraform.tfstate"
    region = "ap-south-1"
}


}

provider "aws" {
  # Configuration options
  region                  = "ap-south-1"
  shared_credentials_file = "C:/Users/Administrator/.aws/shared_credentials_file"
}