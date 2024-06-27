resource "azurerm_resource_group" "example" {
  name     = "a1-rg"
  location = var.location
  tags     = var.tags
}
