provider "aws" {
  region = local.aws_region
}

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "2024-dev-tf-state"
    dynamodb_table = "2024-dev-tf-state-lock"
    key            = "aws-secret-manager"
    region         = "us-east-1"
  }
}

locals {
  aws_region = "us-east-1"
  aws-secret-string = [
    "aurora-cluster-prosgresql-db-username",
    "aurora-cluster-prosgresql-db-password"
  ]


  tags = {
    "id"             = "2024"
    "owner"          = "a1vincent"
    "teams"          = "practical"
    "environment"    = "dev"
    "project"        = "postgres"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

module "aws-secret-manager" {
  source            = "../../modules/aws-secret-manager"
  aws_region        = local.aws_region
  aws-secret-string = local.aws-secret-string
  tags              = local.tags
}

