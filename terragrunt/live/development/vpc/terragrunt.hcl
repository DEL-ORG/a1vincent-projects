terraform {
  source = "../../../modules/vpc_module/vpc-03"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  aws_region       = "us-east-1"
  # cluster_name = "2560-dev-del"
  # cidr_block   = "10.0.0.0/16"
  vpc_cidr_block = "10.0.0.0/16"
  aws_nat_gateway = "1"
  availability_zones = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]

  tags = {
    "id"             = "2024"
    "owner"          = "a1vincent"
    "environment"    = "dev"
    "project"        = "VPC"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}
