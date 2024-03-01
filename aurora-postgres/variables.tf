variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "tags" {
  type = map(any)
  default = {
    "id"             = "2024"
    "owner"          = "a1vincent"
    "teams"          = "practical"
    "environment"    = "dev"
    "project"        = "rds-postgres"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "instance_class" {
  type    = string
  default = "db.r5g.large"
}


variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-0485c796b520799ed", "subnet-04744e1271ed24369"]
}

variable "availability_zones" {
  type    = list(any)
  default = ["us-east-1b", "us-east-1d"]
}

