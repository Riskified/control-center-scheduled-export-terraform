output "sas_query_url" {
  description = "The SAS query URL for the SAS token"
  sensitive   = true
  value       = data.azurerm_storage_account_blob_container_sas.this.sas
}

output "container_url" {
  description = "The URL of the storage container"
  value       = "https://${azurerm_storage_account.this.name}.blob.core.windows.net/${azurerm_storage_container.this.name}"
}
