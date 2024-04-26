region = "us-east-1"
random_s3 = {
  special = false
  upper   = false
  numeric = true
}

tags = {
  id             = "2024"
  owner          = "vincent DevOps"
  teams          = "PD"
  environment    = "dev"
  project        = "S3 Backend"
  create_by      = "Terraform"
  cloud_provider = "aws"
}

s3_versioning = "Enabled"