# terraform {
#   backend "azurerm" {
#     resource_group_name  = "dazhar-rg1"
#     storage_account_name = "dazharstorage1"
#     container_name       = "tfstate"
#     key                  = "terraform.tfstate"
#   }
# }