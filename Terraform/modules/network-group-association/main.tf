resource "azurerm_subnet_network_security_group_association" "dazhar-nsga1" {
  subnet_id                 = var.subnet_id
  network_security_group_id = var.network_security_group_id

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