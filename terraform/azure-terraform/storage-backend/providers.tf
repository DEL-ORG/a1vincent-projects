# terraform {
#   required_version = ">= 1.0.0"
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = ">= 3.0"
#     }
#   }
# }

# terraform {
#   required_version = ">= 1.0.0"
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = ">= 3.0"
#     }
#   }
# }

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "examples-resources" # Replace with your resource group name
#     storage_account_name = "tfstatehb9zwyev10"  # Replace with your storage account name
#     container_name       = "tfstatehb9zwyev10"  # Replace with your container name
#     key                  = "terraform.tfstate"  # This is the name of the state file
#   }
# }
