terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.64.0"
    }
  }

}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
      purge_soft_deleted_secrets_on_destroy      = true
      purge_soft_deleted_certificates_on_destroy = true
    }
  }

    client_id       = "a3037bba-6825-406b-9289-2d507a425108"
  client_secret   = var.client_secret
  tenant_id       = "82c0b871-335f-4b5c-9ed0-a4a23565a79b"
  subscription_id = "a3037bba-6825-406b-9289-2d507a425108"
}
