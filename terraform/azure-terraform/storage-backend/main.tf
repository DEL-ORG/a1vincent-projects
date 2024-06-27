resource "azurerm_resource_group" "example" {
  name     = "a1-rg-storage-backend"
  location = var.location
  tags     = var.tags
}

# Generate a random string for unique naming
resource "random_string" "storage_account_name" {
  length  = 10
  special = false
  lower   = true
  upper   = false
}

# Create a Storage Account with a random suffix
resource "azurerm_storage_account" "example" {
  name                     = "tfstate${random_string.storage_account_name.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # lifecycle {
  #   prevent_destroy = true # Ensure the storage account isn't accidentally destroyed
  # }
}

# Create a Storage Container with a random suffix
resource "azurerm_storage_container" "example" {
  name                  = "tfstate${random_string.storage_account_name.result}"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

# # Output the storage account and container details
# output "storage_account_name" {
#   value = azurerm_storage_account.example.name
# }

# output "container_name" {
#   value = azurerm_storage_container.example.name
# }

# output "resource_group_name" {
#   value = azurerm_resource_group.example.name
# }

# output "location" {
#   value = azurerm_resource_group.example.location
# }
