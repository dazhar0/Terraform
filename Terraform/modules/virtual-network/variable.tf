variable "virtual_network_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "location" {
  type = string
}

variable "address_space" {
  type = any

}

variable "dns_servers" {
  type = list(string)
}
