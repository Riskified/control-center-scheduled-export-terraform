variable "container_name" {
  type        = string
  description = "Name of the storage container"
  default     = "test-container"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "test-resource-group"
}

variable "resource_group_location" {
  type        = string
  description = "Location of the resource group"
  default     = "eastus"
}

variable "resource_group_tags" {
  type        = map(string)
  description = "Tags for the resource group"
  default = {
    environment = "dev"
  }
}

variable "storage_account_name" {
  type        = string
  description = "Name of the storage account"
  default     = "stsrgaccount"
}

variable "storage_account_tags" {
  type        = map(string)
  description = "Tags for the storage account"
  default = {
    environment = "dev"
  }
}

variable "ip_rules" {
  type        = list(string)
  description = "List of IP addresses to whitelist"
  default     = []
}

variable "sas_token_duration" {
  type        = string
  description = "Duration of the SAS token"
  default     = "26280h" # 3 years
}

variable "enable_immutable_storage" {
  type        = bool
  description = "Enable immutable storage"
  default     = true
}
