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

# Define the secret value
variable "secret_value" {
  type        = string
  description = "The value of the secret to be stored in Secrets Manager"
  default     = "my_secret_value" # Replace with your desired secret value
}