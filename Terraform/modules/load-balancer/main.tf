resource "azurerm_lb" "dazhar-load-balancer" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configuration
    content {
      name                          = frontend_ip_configuration.value.name
      public_ip_address_id          = frontend_ip_configuration.value.public_ip_address_id
      private_ip_address_allocation = frontend_ip_configuration.value.private_ip_address_allocation
      subnet_id                     = frontend_ip_configuration.value.subnet_id
    }
  }
}
