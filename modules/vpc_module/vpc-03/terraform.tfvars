region = "us-east-1"

availability_zone = ["us-east-1a", "us-east-1b", "us-east-1c", ]

vpc_cidr_block = "10.0.0.0/16"

tags = {
  type = map(any)
  default = {
    "id"             = "2024"
    "owner"          = "vincent DevOps"
    "teams"          = "PD"
    "environment"    = "dev"
    "project"        = "VPC"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

enable_dns_support = true

enable_dns_hostnames = true

environment = "prod"