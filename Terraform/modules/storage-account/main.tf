resource "azurerm_storage_account" "dazharstorage" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  default_to_oauth_authentication = var.default_to_oauth_authentication
  enable_https_traffic_only       = var.enable_https_traffic_only
  tags                            = var.tags

  /* other properties start */
  account_kind                      = var.account_kind
  allow_nested_items_to_be_public   = var.allow_nested_items_to_be_public
  cross_tenant_replication_enabled  = var.cross_tenant_replication_enabled
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  is_hns_enabled                    = var.is_hns_enabled
  min_tls_version                   = var.min_tls_version
  nfsv3_enabled                     = var.nfsv3_enabled
  public_network_access_enabled     = var.public_network_access_enabled
  queue_encryption_key_type         = var.queue_encryption_key_type
  sftp_enabled                      = var.sftp_enabled
  shared_access_key_enabled         = var.shared_access_key_enabled
  table_encryption_key_type         = var.table_encryption_key_type
  /* other properties end */


  /* Blob Properties Start */
  dynamic "blob_properties" {
    for_each = var.blob_properties
    content {
      change_feed_enabled           = blob_properties.value.change_feed_enabled
      change_feed_retention_in_days = blob_properties.value.change_feed_retention_in_days
      default_service_version       = blob_properties.value.default_service_version
      last_access_time_enabled      = blob_properties.value.last_access_time_enabled
      versioning_enabled            = blob_properties.value.versioning_enabled


      /* making container_delete_retention_policy dynamic with below code */
      /* start */
      # dynamic "container_delete_retention_policy" {
      #   for_each = var.container_delete_retention_policy
      #   content {
      #     days = container_delete_retention_policy.value.days
      #   }
      # }
      /* end */

      # cors_rule {
      #   allowed_headers    = blobproperty.value.allowed_headers
      #   allowed_methods    = blobproperty.value.allowed_methods
      #   allowed_origins    = blobproperty.value.allowed_origins
      #   exposed_headers    = blobproperty.value.exposed_headers
      #   max_age_in_seconds = blobproperty.value.max_age_in_seconds
      # }
      # delete_retention_policy {
      #   days = blobproperty.value.days
      # }

      # restore_policy {
      #   days = blobproperty.value.days
      # }

    }
  }

  /* Blob Properties End */

  dynamic "network_rules" {
    for_each = var.network_rules
    content {
      default_action             = networkruleproperty.value.default_action
      bypass                     = networkruleproperty.value.bypass
      ip_rules                   = networkruleproperty.value.ip_rules
      virtual_network_subnet_ids = networkruleproperty.value.virtual_network_subnet_ids

    }
  }

}



