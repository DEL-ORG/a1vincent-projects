region               = "us-east-1"
vpc_cidr_block       = "10.0.0.0/16"
availability_zone    = ["us-east-1a", "us-east-1b", "us-east-1c"]
enable_dns_support   = true
enable_dns_hostnames = true

tags = {
  id             = "2024"
  owner          = "vincent DevOps"
  teams          = "PD"
  environment    = "dev"
  project        = "VPC"
  create_by      = "Terraform"
  cloud_provider = "aws"
}
