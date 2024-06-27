## Terraform block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  alias  = "main"
  region = local.aws_region_main
}

provider "aws" {
  alias  = "backup"
  region = local.aws_region_backup
}

locals {
  aws_region_main   = "us-east-1"
  aws_region_backup = "us-east-2"

  tags = {
    "id"             = "2024"
    "owner"          = "a1vincent"
    "teams"          = "PD"
    "environment"    = "dev"
    "project"        = "s3-bucket"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

module "s3_backend" {
  source = "github.com/DEL-ORG/a1vincent-projects.git//modules/s3-bucket-with-replication?ref=main"
  tags   = local.tags
}

terraform {
  backend "s3" {
    bucket         = "2024-dev-tf-state"
    dynamodb_table = "2024-dev-tf-state-lock"
    key            = "s3-backend-replica"
    region         = "us-east-1"
  }
}