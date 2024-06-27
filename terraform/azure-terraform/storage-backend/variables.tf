variable "location" {
  type    = string
  default = "EAST US"
}

variable "subscription_id" {
  type    = string
  default = "ad77fc20-fa7a-4024-af6c-4d4296ba44b2"
}

variable "tags" {
  type = map(any)
  default = {
    "id"             = "2024"
    "owner"          = "DevOps Vincent"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "azure"
  }
}



