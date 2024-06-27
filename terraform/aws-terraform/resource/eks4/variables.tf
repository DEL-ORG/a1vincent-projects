variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_iam_role_name" {
  type    = string
  default = "eks_iam_role"

}

variable "name" {
  type    = string
  default = "eks-cluster"
}

variable "eks-cluster" {
  type    = string
  default = "a1vincent-eks-cluster"
}

variable "eks-cluster-version" {
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

variable "subnet_ids" {
  type        = list(string)
  default     = [""]
  description = "list of public subnet IDs"
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


