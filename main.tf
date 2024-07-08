resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name     # name of the resource group
  location = var.resource_group_location # location of the resource group
  tags     = var.resource_group_tags     # tags for the resource group
}

resource "azurerm_storage_account" "this" {
  name                              = var.storage_account_name             # name of the storage account
  resource_group_name               = azurerm_resource_group.this.name     # same resource group as the resource group
  location                          = azurerm_resource_group.this.location # same location as the resource group
  account_kind                      = "StorageV2"                          # StorageV2 is the general-purpose account kind, https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview#types-of-storage-accounts
  account_tier                      = "Standard"                           # Standard performance tier, https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview#types-of-storage-accounts
  account_replication_type          = "LRS"                                # Locally redundant storage, https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy#redundancy-in-the-primary-region
  enable_https_traffic_only         = true                                 # HTTPS traffic only, https://learn.microsoft.com/en-us/azure/storage/common/storage-require-secure-transfer?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json
  min_tls_version                   = "TLS1_2"                             # TLS 1.2, https://learn.microsoft.com/en-us/azure/storage/common/transport-layer-security-configure-minimum-version?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json&tabs=portal#configure-the-minimum-tls-version-for-a-storage-account
  allow_nested_items_to_be_public   = false                                # Do not allow nested items to be public, https://learn.microsoft.com/en-us/azure/storage/blobs/anonymous-read-access-configure?tabs=portal
  public_network_access_enabled     = true                                 # Public network access enabled, https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?tabs=azure-portal#public-network-access
  is_hns_enabled                    = false                                # Is Hierarchical Namespace enabled, needed for azure data lake storage gen2 https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction#data-lake-storage-gen2
  infrastructure_encryption_enabled = false                                # double encryption, see https://learn.microsoft.com/en-us/azure/storage/common/infrastructure-encryption-enable?tabs=portal
  access_tier                       = "Cool"                               # Hot access tier, https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-storage-tiers?tabs=azure-portal
  dns_endpoint_type                 = "Standard"                           # Standard DNS, https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?tabs=azure-portal#dns
  routing {
    choice = "InternetRouting" # Internet routing, https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?tabs=azure-portal#routing-preference
  }
  network_rules {
    bypass         = ["Logging", "Metrics", "AzureServices"] # Azure services bypass, https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?tabs=azure-portal#bypass
    default_action = "Deny"                                  # Deny by default, https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?tabs=azure-portal#default-action
    ip_rules       = var.ip_rules                            # No IP rules, https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?tabs=azure-portal#ip-rules
  }
  sas_policy {
    expiration_action = "Log"         # Log SAS policy, https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?tabs=azure-portal#sas-policy
    expiration_period = "30.00:00:00" # 30 day expiration period, https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?tabs=azure-portal#sas-policy
  }
  tags = var.storage_account_tags # tags for the storage account
}

resource "azurerm_storage_container" "this" {
  name                 = var.container_name                # name of the container
  storage_account_name = azurerm_storage_account.this.name # same storage account as the storage account
}

resource "azurerm_storage_container_immutability_policy" "this" {
  count                                 = var.enable_immutable_storage ? 1 : 0
  storage_container_resource_manager_id = azurerm_storage_container.this.resource_manager_id
  immutability_period_in_days           = 14
  protected_append_writes_all_enabled   = false
  protected_append_writes_enabled       = true
}

data "azurerm_storage_account_blob_container_sas" "this" {
  connection_string = azurerm_storage_account.this.primary_connection_string
  container_name    = azurerm_storage_container.this.name
  https_only        = true
  start             = timestamp()
  expiry            = timeadd(timestamp(), var.sas_token_duration)
  permissions {
    read   = false
    add    = false
    create = true
    write  = true
    delete = false
    list   = false
  }
}
