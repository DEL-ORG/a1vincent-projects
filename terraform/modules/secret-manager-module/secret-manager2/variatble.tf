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
    "project"        = "secret-manager"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

variable "rotation-window" {
  type    = number
  default = 0
}

# variable "keys" {
#   type = map(string)
#   default = {
#     "key1" = "value1"
#     "key2" = "value2"
#   }
# }