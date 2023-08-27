variable "csv_file_name" {
  type    = string
  default = null
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

# variable "name" {
#   type = any
# }