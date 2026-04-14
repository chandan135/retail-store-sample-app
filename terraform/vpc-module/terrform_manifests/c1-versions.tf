# Terraform Block
terraform {
  required_version = "~>1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"
    }
  }

  # Remote Backend
  backend "s3" {
    bucket       = "tfstate-dev-us-east-1-nc603u54npkr5plm"
    key          = "retail-store-sample-app-infra/dev/vpc-module/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
    region       = "us-east-1"
  }
}

# Provider Block
provider "aws" {
  region = var.aws_region
}