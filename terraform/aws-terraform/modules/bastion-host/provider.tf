# terraform {
#   required_version = "~> 1.0.0"
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.0"
#     }
#   }
# }

# provider "aws" {
#   region = local.aws_region
# }

# terraform {
#   backend "s3" {
#     bucket         = "2024-dev-tf-state"
#     dynamodb_table = "2024-dev-tf-state-lock"
#     key            = "bastion-host"
#     region         = "us-east-1"
#   }
# }