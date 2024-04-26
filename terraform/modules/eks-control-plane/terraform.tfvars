aws_region              = "us-east-1"
cluster_name            = "eks"
cluster-version         = "1.28"
endpoint_private_access = false
endpoint_public_access  = true
tags = {
  "id"             = "2024"
  "owner"          = "a1vincent"
  "teams"          = "practical"
  "environment"    = "dev"
  "project"        = "eks"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}

subnet_ids = [
  "subnet-0fd0fd2e8aeb61428",
  "subnet-019c6427c1f8e7efe",
  "subnet-0e0e8dbbbfab39bbf",
]


