aws_region = "us-east-1"

availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c", ]

vpc_cidr_block = "10.0.0.0/16"

tags = {

  "id"             = "2024"
  "owner"          = "a1vincent"
  "teams"          = "PD"
  "environment"    = "dev"
  "project"        = "VPC"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}

enable_dns_support = true

enable_dns_hostnames = true

environment = "dev"