variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "name" {
  type    = string
  default = "eks-cluster"
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

#Assuming you already have subnet IDs, you can define them as variables
variable "public_subnet_ids" {
  type = list(string)
  default = [
    "subnet-0664e238d971b4a8e",
    "subnet-077c09f3ebf21492a",
    "subnet-012216369ad5342c9",
  ]
  description = "list of public subnet IDs"
}

variable "private_subnet_ids" {
  type = list(string)
  default = [
    "subnet-02adcc2305b34bbc8",
    "subnet-06af1ca8b7eb2a9b1",
    "subnet-064e788b552bf7a07"
  ]
  description = "list of private subnet IDs"
}