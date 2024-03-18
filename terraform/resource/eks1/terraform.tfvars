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
  "subnet-0a76577202f6f1b00",
  "subnet-03a63d535b0c877d3",
  "subnet-0abc9b1709b6c4cc1"
]

private_subnet_ids = [
  "subnet-0550f861abd03bbad",
  "subnet-0c20415faf10875b7",
  "subnet-0812b9c88508c415f"
]