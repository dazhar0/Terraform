locals {
  # read csv file
  list_of_csv_lines = csvdecode(file(var.csv_file_name))
  # collect all nsg names , (Unique)
  all_nsg_names = distinct([for item in local.list_of_csv_lines : item.nsg_name])
  # collect all nsg names other syntax , (Unique)
  all_nsg_names_again = distinct(local.list_of_csv_lines[*].nsg_name)


  # Loop over all unique names ---> for item in local.all_nsg_names : 
  # create a key of nsg name item ----> "${item}" =>
  # And to now fill value in that dictionary item key, 
  # Loop over list of csv lines  
  # pick the line 
  # if nsg_name matches item
  combine = {
    for item in local.all_nsg_names :
    "${item}" => [
      for line in local.list_of_csv_lines : line
      if item == line.nsg_name
    ]
  }



}

resource "azurerm_network_security_group" "dazhar-nsg" {
  for_each = local.combine

  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  dynamic "security_rule" {
    for_each = each.value

    content {
      name                       = security_rule.value["rule_name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }

}





