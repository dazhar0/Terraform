variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "frontend_ip_configuration" {
  type = any
}

variable "sku" {
  type = string
}

#  variable "subnet_id" {
#     type = any
#  }

#  variable "private_ip_address_allocation" {
#     type = string
#  }

#  variable "public_ip_address_id" {
#     type = any
#  }

#  variable "public_ip_prefix_id" {
#     type = any
#  }