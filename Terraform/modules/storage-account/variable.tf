variable "name" {
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

variable "account_tier" {
  type = string
}

variable "account_replication_type" {
  type = string
}

variable "blob_properties" {
  type    = any
  default = {}
}

variable "account_kind" {
  type = string
}


variable "allow_nested_items_to_be_public" {
  type    = string
  default = "true"
}

variable "cross_tenant_replication_enabled" {
  type    = string
  default = "true"
}

variable "default_to_oauth_authentication" {
  type    = string
  default = "false"
}

variable "enable_https_traffic_only" {
  type = string
}

variable "infrastructure_encryption_enabled" {
  type    = string
  default = "false"
}

variable "is_hns_enabled" {
  type    = string
  default = "false"
}

variable "min_tls_version" {
  type    = any
  default = {}
}
variable "nfsv3_enabled" {
  type    = string
  default = false
}

variable "public_network_access_enabled" {
  type    = string
  default = true
}
variable "queue_encryption_key_type" {
  type    = string
  default = "Service"
}

variable "sftp_enabled" {
  type    = string
  default = false
}


variable "shared_access_key_enabled" {
  type    = string
  default = false
}


variable "table_encryption_key_type" {
  type    = string
  default = "Service"
}

variable "container_delete_retention_policy" {
  type    = any
  default = {}
}

variable "network_rules" {
  type    = any
  default = {}
}
