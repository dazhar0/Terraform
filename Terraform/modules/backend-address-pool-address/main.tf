resource "azurerm_lb_backend_address_pool_address" "dazhar-lb-address-pool-address" {
  name                                = var.name
  backend_address_pool_id             = var.backend_address_pool_id
  backend_address_ip_configuration_id = var.backend_address_ip_configuration_id
}