resource "azurerm_resource_group" "dazhar-rg" {
  name     = var.name
  location = var.location
  tags     = var.tags
}