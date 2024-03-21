variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "name" {
  type    = string
  default = "eks-node-groups"
}

variable "tags" {
  type = map(any)
  default = {
    "id"             = "2024"
    "owner"          = "a1vincent"
    "teams"          = "practical"
    "environment"    = "dev"
    "project"        = "eks-node-groups"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

#Assuming you already have subnet IDs, you can define them as variables
variable "public_subnet_ids" {
  type = list(string)
  default = [
    "subnet-0a76577202f6f1b00",
    "subnet-03a63d535b0c877d3",
    "subnet-0abc9b1709b6c4cc1"
  ]
  description = "list of public subnet IDs"
}

variable "private_subnet_ids" {
  type = list(string)
  default = [
    "subnet-0550f861abd03bbad",
    "subnet-0c20415faf10875b7",
    "subnet-0812b9c88508c415f"
  ]
  description = "list of private subnet IDs"
}