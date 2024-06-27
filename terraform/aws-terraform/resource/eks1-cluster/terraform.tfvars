aws_region = "us-east-1"

name = "eks-cluster"

tags = {
  "id"             = "2024"
  "owner"          = "a1vincent"
  "teams"          = "practical"
  "environment"    = "dev"
  "project"        = "eks"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}

public_subnet_ids = [
  "subnet-0664e238d971b4a8e",
  "subnet-077c09f3ebf21492a",
  "subnet-012216369ad5342c9",
]

private_subnet_ids = [
  "subnet-02adcc2305b34bbc8",
  "subnet-06af1ca8b7eb2a9b1",
  "subnet-064e788b552bf7a07"
]