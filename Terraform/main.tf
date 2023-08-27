module "rggroup" {
  source   = "./modules/resource-group"
  name     = "${var.environment}-${var.resource_group_name}"
  location = var.location
}


module "storageaccount" {
  source                            = "./modules/storage-account"
  for_each                          = local.staccount
  name                              = each.value.name
  resource_group_name               = module.rggroup.main.name
  location                          = var.location
  account_tier                      = each.value.account_tier
  account_replication_type          = each.value.account_replication_type
  default_to_oauth_authentication   = each.value.default_to_oauth_authentication
  enable_https_traffic_only         = each.value.enable_https_traffic_only
  account_kind                      = each.value.account_kind
  allow_nested_items_to_be_public   = each.value.allow_nested_items_to_be_public
  cross_tenant_replication_enabled  = each.value.cross_tenant_replication_enabled
  infrastructure_encryption_enabled = each.value.infrastructure_encryption_enabled
  is_hns_enabled                    = each.value.is_hns_enabled
  min_tls_version                   = each.value.min_tls_version
  nfsv3_enabled                     = each.value.nfsv3_enabled
  public_network_access_enabled     = each.value.public_network_access_enabled
  queue_encryption_key_type         = each.value.queue_encryption_key_type
  sftp_enabled                      = each.value.sftp_enabled
  shared_access_key_enabled         = each.value.shared_access_key_enabled
  table_encryption_key_type         = each.value.table_encryption_key_type

  blob_properties = try(each.value.blob_properties, [])
}


locals {
  staccount = {
    staccount1 = {
      name                              = "${var.environment}dazharstorage1"
      account_tier                      = "Premium"
      account_replication_type          = "LRS"
      default_to_oauth_authentication   = "true"
      enable_https_traffic_only         = "false"
      account_kind                      = "StorageV2"
      allow_nested_items_to_be_public   = "true"
      cross_tenant_replication_enabled  = "true"
      infrastructure_encryption_enabled = "false"
      is_hns_enabled                    = "false"
      min_tls_version                   = "TLS1_2"
      nfsv3_enabled                     = "false"
      public_network_access_enabled     = "true"
      queue_encryption_key_type         = "Service"
      sftp_enabled                      = "false"
      shared_access_key_enabled         = "true"
      table_encryption_key_type         = "Service"

      blob_properties = [
        {
          change_feed_enabled               = true
          change_feed_retention_in_days     = 29
          default_service_version           = "2009-07-17"
          last_access_time_enabled          = false
          versioning_enabled                = false
          container_delete_retention_policy = 3
        }


        # container_delete_retention_policy = {
        #   days = 2
        # }

        # cors_rule = {
        #   allowed_headers    = true,
        #   allowed_methods    = true,
        #   allowed_origins    = false,
        #   exposed_headers    = false,
        #   max_age_in_seconds = "5.000"
        # }
      ]

    }
    staccount2 = {
      name                              = "${var.environment}dazharstorage2"
      account_tier                      = "Premium"
      account_replication_type          = "LRS"
      default_to_oauth_authentication   = "true"
      enable_https_traffic_only         = "false"
      account_kind                      = "StorageV2"
      allow_nested_items_to_be_public   = "true"
      cross_tenant_replication_enabled  = "true"
      infrastructure_encryption_enabled = "false"
      is_hns_enabled                    = "false"
      min_tls_version                   = "TLS1_2"
      nfsv3_enabled                     = "false"
      public_network_access_enabled     = "true"
      queue_encryption_key_type         = "Service"
      sftp_enabled                      = "false"
      shared_access_key_enabled         = "true"
      table_encryption_key_type         = "Service"

      blob_properties = [
        {
          change_feed_enabled           = true
          change_feed_retention_in_days = 29
          default_service_version       = "2009-07-17"
          last_access_time_enabled      = false
          versioning_enabled            = false
        }


        # container_delete_retention_policy = {
        #   days = 2
        # }

        # cors_rule = {
        #   allowed_headers    = true
        #   allowed_methods    = true
        #   allowed_origins    = false
        #   exposed_headers    = false
        #   max_age_in_seconds = "5.000"
        # }
      ]


    }
  }
}


module "virtualnetwork" {
  source               = "./modules/virtual-network"
  for_each             = local.vnetwork
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = module.rggroup.main.name
  location             = var.location
  address_space        = each.value.address_space
  dns_servers          = each.value.dns_servers
}


locals {
  vnetwork = {
    vnetwork1 = {
      virtual_network_name = "${var.environment}-dazhar-vn1"
      address_space        = ["10.0.0.0/24"]
      dns_servers          = ["10.0.0.4", "10.0.0.5"]
    }

    vnetwork2 = {
      virtual_network_name = "${var.environment}-dazhar-vn2"
      address_space        = ["10.1.0.0/24"]
      dns_servers          = ["10.0.0.6", "10.0.0.7"]
    }
  }

}


module "subnet" {
  source                                        = "./modules/subnet"
  for_each                                      = local.sbnet
  name                                          = each.value.name
  resource_group_name                           = module.rggroup.main.name
  location                                      = var.location
  virtual_network_name                          = each.value.virtual_network_name
  address_prefixes                              = each.value.address_prefixes
  private_endpoint_network_policies_enabled     = each.value.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_enabled


  delegation = [
    {
      delegation_name           = "delegation12345"
      service_delegation_name   = "Microsoft.ContainerInstance/containerGroups"
      service_delegation_action = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    },
    # Add more delegation objects as needed
  ]

}


locals {
  sbnet = {
    vn1-snet1 = {
      name                                          = "${var.environment}-dazhar-subnet1"
      virtual_network_name                          = module.virtualnetwork["vnetwork1"].main.name
      address_prefixes                              = [element(cidrsubnets(join(",", module.virtualnetwork["vnetwork1"].main.address_space), 5, 6, 8), 0)]
      private_endpoint_network_policies_enabled     = "true"
      private_link_service_network_policies_enabled = "false"
      # delegation = [
      #   {
      #     delegation_name           = "delegation12345"
      #     service_delegation_name   = "Microsoft.ContainerInstance/containerGroups"
      #     service_delegation_action = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
      #   }
      # ]
    }
    vn1-snet2 = {
      name                                          = "${var.environment}-dazhar-subnet2"
      virtual_network_name                          = module.virtualnetwork["vnetwork1"].main.name
      address_prefixes                              = [element(cidrsubnets(join(",", module.virtualnetwork["vnetwork1"].main.address_space), 5, 5, 8), 1)]
      private_endpoint_network_policies_enabled     = "true"
      private_link_service_network_policies_enabled = "false"
      # delegation = [
      #   {
      #     delegation_name           = "delegation123457890"
      #     service_delegation_name   = "Microsoft.ContainerInstance/containerGroups"
      #     service_delegation_action = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
      #   }
      # ]

    }
    vn2-snet2 = {
      name                                          = "${var.environment}-dazhar-subnet2"
      virtual_network_name                          = module.virtualnetwork["vnetwork2"].main.name
      address_prefixes                              = [element(cidrsubnets(join(",", module.virtualnetwork["vnetwork2"].main.address_space), 5, 6, 8), 0)]
      private_endpoint_network_policies_enabled     = "true"
      private_link_service_network_policies_enabled = "false"
    }
  }
}

module "public_ip" {
  source                  = "./modules/public-ip"
  count                   = 2
  name                    = "${var.environment}-dazhar-public-ip-${count.index + 1}"
  resource_group_name     = module.rggroup.main.name
  location                = var.location
  allocation_method       = "Static"
  zones                   = [1]
  ddos_protection_mode    = "Disabled"
  idle_timeout_in_minutes = "20"
  ip_version              = "IPv4"
  sku                     = "Standard"
  sku_tier                = "Regional"

  timeouts = [
    {
      create = "30m"
      update = "30m"
      read   = "5m"
      delete = "5m"
    }
  ]
}

module "network-security-group" {
  source        = "./modules/network-security-group"
  csv_file_name = var.csv_file_name
  location      = var.location

  resource_group_name = module.rggroup.main.name

}


module "network-interface" {
  source              = "./modules/network-interface"
  for_each            = local.nic
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  ip_configuration = each.value.ip_configuration
}


locals {
  nic = {
    nic1 = {

      name                = "${var.environment}-dazhar-nic1"
      resource_group_name = module.rggroup.main.name
      location            = var.location

      ip_configuration = [
        {
          name                          = "internal"
          subnet_id                     = module.subnet["vn1-snet1"].main.id
          private_ip_address_allocation = "Dynamic"
        }
      ]
    }

    nic2 = {
      name                = "${var.environment}-dazhar-nic2"
      resource_group_name = module.rggroup.main.name
      location            = module.rggroup.main.location

      ip_configuration = [
        {
          name                          = "internal"
          subnet_id                     = module.subnet["vn1-snet2"].main.id
          private_ip_address_allocation = "Dynamic"
        }
      ]
    }
  }
}


module "load-balancer" {
  source              = "./modules/load-balancer"
  name                = "${var.environment}-dazhar-lb1"
  resource_group_name = module.rggroup.main.name
  location            = var.location
  sku                 = "Standard"

  frontend_ip_configuration = [
    {
      name                          = "publicIPaddress1"
      public_ip_address_id          = module.public_ip["1"].main.id
      private_ip_address_allocation = "Dynamic"
      subnet_id                     = module.subnet["vn1-snet1"].main.id
    }
  ]

}

module "load-balancer-backend-address-pool" {
  source             = "./modules/ld-backend-address-pool"
  name               = "${var.environment}-BackendAddressPool1"
  loadbalancer_id    = module.load-balancer.main.id
  virtual_network_id = module.virtualnetwork["vnetwork1"].main.id
}




module "load-balancer-backend-address-pool-address" {
  source                              = "./modules/backend-address-pool-address"
  name                                = "${var.environment}-PoolAddress1"
  backend_address_pool_id             = module.load-balancer-backend-address-pool.main.id
  backend_address_ip_configuration_id = module.network-interface["nic1"].main.private_ip_address
}

module "virtual-machine" {
  source                = "./modules/virtual-machine"
  for_each              = local.vm
  name                  = each.value.name
  resource_group_name   = each.value.resource_group_name
  location              = each.value.location
  size                  = each.value.size
  admin_username        = each.value.admin_username
  network_interface_ids = each.value.network_interface_ids
  # admin_ssh_key          = each.value.admin_ssh_key
  # os_disk                = each.value.os_disk
  # source_image_reference = each.value.source_image_reference
}



locals {
  vm = {
    vm1 = {
      name                  = "${var.environment}-dazhar-vm1"
      resource_group_name   = module.rggroup.main.name
      location              = var.location
      size                  = "Standard_F2"
      admin_username        = "adminuser"
      network_interface_ids = module.network-interface["nic1"].main.id
      admin_ssh_key = {
        username   = "user1"
        public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0ulz3a9zlmKtcLBWZ6QUUJQJUPNdHOT9MhaORRcH2VUNfFuD/vKR0RgYaNa3FVtPi9S6Ee5kr63Y3isd833BN4S4UP7XlzA2A2wlnhJbfP3hYMylSz3yJgWJu1XhYlnA/gFUTBfJYh2esJ6oPG2EQ3LDNibLzqzbit9PT31ZUjwF6IpJAUlkkSKwDX/U4uLFWhuAkl1pONkCBnqDwgZtfYkI7oFpV4UA50faS5rQxp6KquEiYDgX+RKVwtrmD5htN5XR138LP4xUHfrBXbXsFSU0t2KgAjMdDZ84XJMkXXJhsPfJqoWpMoUKZYLrurvS7LNuANFieq757JeZuxn5ynTKHwI5Zv1bwHsnO66M9kLgp8ve/jxpI9dBW4fT0G7dvcWBWX/nk5g3uzOvLpF4HN2/iJe5e2fLENbDdUDpiohDWBepg6bq2/L6Xx+J/cxMZjjZpjwAOEnccXUcdMFhOZFQjNAhHmhmFf4H/jr9fM2JbKvpP5z/FQ88rSZyQTPs="

        os_disk = {
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "Canonical"
          offer     = "0001-com-ubuntu-server-focal"
          sku       = "20_04-lts"
          version   = "latest"
        }
      }
    }

    vm2 = {
      name                  = "${var.environment}-dazhar-vm2"
      resource_group_name   = module.rggroup.main.name
      location              = var.location
      size                  = "Standard_F2"
      admin_username        = "adminuser"
      network_interface_ids = module.network-interface["nic2"].main.id
      admin_ssh_key = {
        username   = "user2"
        public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0ulz3a9zlmKtcLBWZ6QUUJQJUPNdHOT9MhaORRcH2VUNfFuD/vKR0RgYaNa3FVtPi9S6Ee5kr63Y3isd833BN4S4UP7XlzA2A2wlnhJbfP3hYMylSz3yJgWJu1XhYlnA/gFUTBfJYh2esJ6oPG2EQ3LDNibLzqzbit9PT31ZUjwF6IpJAUlkkSKwDX/U4uLFWhuAkl1pONkCBnqDwgZtfYkI7oFpV4UA50faS5rQxp6KquEiYDgX+RKVwtrmD5htN5XR138LP4xUHfrBXbXsFSU0t2KgAjMdDZ84XJMkXXJhsPfJqoWpMoUKZYLrurvS7LNuANFieq757JeZuxn5ynTKHwI5Zv1bwHsnO66M9kLgp8ve/jxpI9dBW4fT0G7dvcWBWX/nk5g3uzOvLpF4HN2/iJe5e2fLENbDdUDpiohDWBepg6bq2/L6Xx+J/cxMZjjZpjwAOEnccXUcdMFhOZFQjNAhHmhmFf4H/jr9fM2JbKvpP5z/FQ88rSZyQTPs="
      }

      os_disk = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }

      source_image_reference = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-focal"
        sku       = "20_04-lts"
        version   = "latest"
      }
    }
  }
}

data "azurerm_client_config" "current" {}


module "key-vault" {
  source              = "./modules/key-vault"
  name                = "${var.environment}-dazhar-key-vault"
  location            = var.location
  resource_group_name = module.rggroup.main.name
  for_each            = local.keyvault

  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  tenant_id                   = each.value.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled

  sku_name = each.value.sku_name

}


locals {
  keyvault = {
    vault = {
      name                = "${var.environment}-dazhar-key-vault"
      location            = var.location
      resource_group_name = module.rggroup.main.name

      enabled_for_disk_encryption = true
      tenant_id                   = data.azurerm_client_config.current.tenant_id
      soft_delete_retention_days  = 7
      purge_protection_enabled    = false

      sku_name = "standard"

      access_policy = {
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = data.azurerm_client_config.current.object_id

        key_permissions = [
          "Get",
        ]

        secret_permissions = [
          "Get",
        ]

        storage_permissions = [
          "Get",
        ]
      }

    }
  }
}

# module "key-vault-secret" {
#   source       = "./modules/key-vault-secret"
#   name         = "secret-sauce"
#   value        = "0987654321"
#   key_vault_id = module.key-vault["vault"].main.id
# }