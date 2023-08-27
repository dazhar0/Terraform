output "resource-group" {
  value = module.rggroup.main
}

output "private_ip_address" {
  value = module.network-interface["nic1"].main.private_ip_address
}


output "virtual_machine_names" {
  value = [for vm_name, vm_config in local.vm : vm_config.name]
}


output "sb" {
  value = [for name, config in local.sbnet : config.name]
}


output "key-vault" {
  value = [for vm_name, vm_config in local.keyvault : vm_config.name]

}

output "key-vault-secret-id" {
  value = module.key-vault-secret.main.id
}
output "object_id" {
  value = data.azurerm_client_config.current.object_id
}