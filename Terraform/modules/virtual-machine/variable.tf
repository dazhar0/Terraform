variable "name" {
  description = "Name of virtual machine "
}

variable "resource_group_name" {
  description = "Name of the resource Group"
  type        = string
  default     = null
}

variable "location" {
  description = "enviroment in which you are working"
  type        = string
  default     = null
}

variable "size" {
  description = "size of virtual machine"
  type        = string
}

variable "admin_username" {
  description = "admin username of virtual machine"
  type        = string
}

variable "network_interface_ids" {
  description = "id of the network interface"
  type        = any
}