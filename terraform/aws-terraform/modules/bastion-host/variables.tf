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
    "environment"    = "dev"
    "project"        = "bastion-host"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

# variable "aws_region" {
#   description = "The AWS region where resources will be provisioned."
#   default     = "us-east-1"
# }

# variable "instance_type" {
#   description = "The type of EC2 instance to launch."
#   default     = "t2.micro"
# }

# variable "aws_access_key" {
#   description = "AWS Access Key ID"
#   type        = string
#   sensitive   = true
# }

# variable "aws_secret_key" {
#   description = "AWS Secret Access Key"
#   type        = string
#   sensitive   = true
# }