variable "resource_group_name" {}
variable "location" {}
variable "environment" {}

variable "csv_file_name" {
  type    = string
  default = "nsg-rules.csv"
}