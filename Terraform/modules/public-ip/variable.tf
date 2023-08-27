variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "allocation_method" {
  type = string
}

variable "tags" {
  type    = any
  default = {}
}

variable "zones" {
  type = any
}

variable "ddos_protection_mode" {
  type = string
}

variable "idle_timeout_in_minutes" {
  type = string
}

variable "ip_version" {
  type = string
}

variable "sku" {
  type = string
}

variable "sku_tier" {
  type = string
}

variable "timeouts" {
  type = any
}