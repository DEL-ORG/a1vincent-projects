variable "aws_region" {
  type = string
}

variable "aws-secret-string" {
  type = list(string)
  default = [
    "mysql-db-password",
    "postges-aurora-db-password",
    "postgres-db",
    "mysql-aurora-db-password"
  ]
}

variable "tags" {
  type = map(string)
  default = {
    "id"             = "2024"
    "owner"          = "a1vincent"
    "teams"          = "PD"
    "environment"    = "dev"
    "project"        = "VPC"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}