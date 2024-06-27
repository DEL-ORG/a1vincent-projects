terraform {
  backend "azurerm" {
    resource_group_name  = "a1-rg-storage-backend"        # Replace with your resource group name
    storage_account_name = "tfstatehb9zwyev10"            # Replace with your storage account name
    container_name       = "tfstatehb9zwyev10"            # Replace with your container name
    key                  = "windows-vm/terraform.tfstate" # This is the name of the state file
  }
}