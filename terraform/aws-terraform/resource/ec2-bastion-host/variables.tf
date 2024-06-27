variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "tags" {
  type = map(any)
  default = {
    "id"             = "2025"
    "owner"          = "a1vincent"
    "teams"          = "PD"
    "environment"    = "qa"
    "project"        = "bastion-host1"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}