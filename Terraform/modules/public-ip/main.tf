resource "azurerm_public_ip" "dazhar-ip" {
  name                    = var.name
  resource_group_name     = var.resource_group_name
  location                = var.location
  allocation_method       = var.allocation_method
  tags                    = var.tags
  zones                   = var.zones
  ddos_protection_mode    = var.ddos_protection_mode
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  ip_version              = var.ip_version
  sku                     = var.sku
  sku_tier                = var.sku_tier

  dynamic "timeouts" {
    for_each = var.timeouts
    content {
      create = timeouts.value.create
      update = timeouts.value.update
      read   = timeouts.value.read
      delete = timeouts.value.delete
    }
  }

}
