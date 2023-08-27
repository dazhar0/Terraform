variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "address_prefixes" {
  type = list(string)

}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "location" {
  type = string
}

variable "private_endpoint_network_policies_enabled" {
  type = string
}

variable "private_link_service_network_policies_enabled" {
  type = string
}

# variable "delegation_name" {
#   type    = string

# }

# variable "service_delegation_name" {
#   type = string
# }

# variable "service_delegation_action" {
#   type = any
# }

variable "delegation" {
  type = any
}