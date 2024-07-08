## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.71.0, < 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.111.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container_immutability_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container_immutability_policy) | resource |
| [azurerm_storage_account_blob_container_sas.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account_blob_container_sas) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Name of the storage container | `string` | `"test-container"` | no |
| <a name="input_ip_rules"></a> [ip\_rules](#input\_ip\_rules) | List of IP addresses to whitelist | `list(string)` | `[]` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Location of the resource group | `string` | `"eastus"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | `"test-resource-group"` | no |
| <a name="input_resource_group_tags"></a> [resource\_group\_tags](#input\_resource\_group\_tags) | Tags for the resource group | `map(string)` | <pre>{<br>  "environment": "dev"<br>}</pre> | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Name of the storage account | `string` | `"stsrgaccount"` | no |
| <a name="input_storage_account_tags"></a> [storage\_account\_tags](#input\_storage\_account\_tags) | Tags for the storage account | `map(string)` | <pre>{<br>  "environment": "dev"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_url"></a> [container\_url](#output\_container\_url) | The URL of the storage container |
| <a name="output_sas_query_url"></a> [sas\_query\_url](#output\_sas\_query\_url) | The SAS query URL for the SAS token |
