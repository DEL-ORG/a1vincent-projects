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
  region = local.aws_region
}

locals {
  aws_region = "us-east-1"

  tags = {

    "id"             = "2024"
    "owner"          = "a1vincent"
    "teams"          = "PD"
    "environment"    = "dev"
    "project"        = "VPC"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }

  vpc_id              = "vpc-030e24dca629c0007"
  subnet_ids          = ["subnet-0485c796b520799ed", "subnet-04744e1271ed24369"]
  availability_zones  = ["us-east-1b", "us-east-1d"]
  instance_count      = 2
  publicly_accessible = false
  sg_port             = 5432
  instance_class      = "db.r5.large"
  deletion_window     = 0


  cluster = {
    cluster_identifier      = "aurora-cluster-prosgresql"
    engine                  = "aurora-postgresql"
    engine_version          = "11"
    database_name           = "a1vincent_db"
    master_username         = "adminuser"
    master_password         = "db_master_password" # Use input variable here
    backup_retention_period = 0
    preferred_backup_window = "07:00-09:00"
    deletion_protection     = false
    storage_encrypted       = true
    skip_final_snapshot     = true # Set to false if you want to take a final snapshot when deleting the cluster
  }
}

module "auro-postgres" {
  source = "git@github.com:DEL-ORG/a1vincent-projects.git//terraform/modules/aurora-postgres-module?ref=main"
  //source = "../../modules/aurora-postgres-module"
  aws_region          = local.aws_region
  tags                = local.tags
  vpc_id              = local.vpc_id
  AZ                  = local.availability_zones
  subnet_ids          = local.subnet_ids
  inst_count          = local.inst_count
  sg_port             = local.sg_port
  publicly_accessible = local.publicly_accessible
  instance_class      = local.instance_class
  cluster             = local.cluster
  deletion_window     = local.deletion_window
}