# Terraform Block
terraform {
  required_version = "~> 1.4 "
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.42.0"
    }
     null = {
      source = "hashicorp/null"
      version = "3.2.2"
    }
    random = {
      source = "hashicorp/random"
      version = "~>3.0"
    }
  }
  backend "s3" {
    
  }
}


provider "aws" {
  # Configuration options
  region = var.aws_region
}

/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/
