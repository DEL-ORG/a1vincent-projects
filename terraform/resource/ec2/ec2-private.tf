terraform {
  required_version = "~> 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = local.aws_region
}

terraform {
  backend "s3" {
    bucket         = "2024-dev-tf-state"
    dynamodb_table = "2024-dev-tf-state-lock"
    key            = "ec2private"
    region         = "us-east-1"
  }
}

locals {
  aws_region             = "us-east-1"
  ami                    = "ami-080e1f13689e07408"
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["sg-032ff37a7c0e750ae"]
  subnet_id              = "subnet-04644a5b655942053"
  volume_size            = "10"

  tags = {
    Name = "ec2-private"

  }
}

# create the AWS instance using the local variable
resource "aws_instance" "ec2-private" {

  ami                    = local.ami
  instance_type          = local.instance_type
  key_name               = local.key_name
  vpc_security_group_ids = local.vpc_security_group_ids
  subnet_id              = local.subnet_id

  root_block_device {
    volume_size = local.volume_size
  }

  tags = local.tags
}

# tags = {
#   "id"             = "2024"
#   "owner"          = "a1vincent"
#   "teams"          = "PD"
#   "environment"    = "dev"
#   "project"        = "ec2-private"
#   "create_by"      = "Terraform"
#   "cloud_provider" = "aws"
# }
