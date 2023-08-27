resource "azurerm_linux_virtual_machine" "dazhar-vm" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = var.admin_username
  network_interface_ids = [
    var.network_interface_ids
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0ulz3a9zlmKtcLBWZ6QUUJQJUPNdHOT9MhaORRcH2VUNfFuD/vKR0RgYaNa3FVtPi9S6Ee5kr63Y3isd833BN4S4UP7XlzA2A2wlnhJbfP3hYMylSz3yJgWJu1XhYlnA/gFUTBfJYh2esJ6oPG2EQ3LDNibLzqzbit9PT31ZUjwF6IpJAUlkkSKwDX/U4uLFWhuAkl1pONkCBnqDwgZtfYkI7oFpV4UA50faS5rQxp6KquEiYDgX+RKVwtrmD5htN5XR138LP4xUHfrBXbXsFSU0t2KgAjMdDZ84XJMkXXJhsPfJqoWpMoUKZYLrurvS7LNuANFieq757JeZuxn5ynTKHwI5Zv1bwHsnO66M9kLgp8ve/jxpI9dBW4fT0G7dvcWBWX/nk5g3uzOvLpF4HN2/iJe5e2fLENbDdUDpiohDWBepg6bq2/L6Xx+J/cxMZjjZpjwAOEnccXUcdMFhOZFQjNAhHmhmFf4H/jr9fM2JbKvpP5z/FQ88rSZyQTPs="
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}