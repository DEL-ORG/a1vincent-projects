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
    "project"        = "eks"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

variable "cluster_name" {
  type    = string
  default = "control-plane"
}

variable "cluster-version" {
  type    = string
  default = "1.28"
}

variable "endpoint_private_access" {
  type    = bool
  default = false
}

variable "endpoint_public_access" {
  type    = bool
  default = true
}

variable "force_update_version" {
  type    = bool
  default = false
}

variable "subnet_ids" {
  type = list(string)
  default = [
    "subnet-0fd0fd2e8aeb61428",
    "subnet-019c6427c1f8e7efe",
    "subnet-0e0e8dbbbfab39bbf",
  ]
  description = "list of public subnet IDs"
}















