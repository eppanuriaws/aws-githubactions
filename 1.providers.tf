terraform {
  required_version = "1.9.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.64.0"
    }
  }
  backend "s3" {
    bucket = "devsecopsb42-terraform-state-new"
    key    = "devsecopsb42.tfstate"
    region = "us-east-1"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "devsecopsb42-terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {}