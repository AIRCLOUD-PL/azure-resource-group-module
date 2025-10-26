# Azure Resource Group Terraform Module

This Terraform module creates enterprise-grade Azure Resource Groups with governance, security, and compliance features.

## Features

- **Resource Group Creation**: Create resource groups with proper naming and tagging
- **Resource Locks**: Prevent accidental deletion or modification
- **Policy Integration**: Built-in Azure Policy definitions for governance
- **Enterprise Ready**: Comprehensive tagging and metadata management

## Usage

```hcl
module "resource_group" {
  source = "./modules/management/resource-group"

  name     = "rg-my-project-prod"
  location = "East US 2"

  tags = {
    Environment = "production"
    Project     = "my-project"
    Owner       = "platform-team"
  }

  enable_resource_lock = true
  lock_level          = "CanNotDelete"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.80.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.80.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_management_lock.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_policy_definition.resource_group_naming](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition) | resource |
| [azurerm_policy_definition.resource_group_location](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition) | resource |
| [azurerm_policy_definition.resource_group_required_tags](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure region where the resource group will be created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the resource group | `map(string)` | `{}` | no |
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | Whether to create the resource group | `bool` | `true` | no |
| <a name="input_enable_resource_lock"></a> [enable\_resource\_lock](#input\_enable\_resource\_lock) | Enable resource lock for the resource group | `bool` | `false` | no |
| <a name="input_lock_level"></a> [lock\_level](#input\_lock\_level) | Resource lock level: CanNotDelete or ReadOnly | `string` | `"CanNotDelete"` | no |
| <a name="input_create_custom_policies"></a> [create\_custom\_policies](#input\_create\_custom\_policies) | Create custom Azure Policy definitions for resource groups | `bool` | `false` | no |
| <a name="input_approved_locations"></a> [approved\_locations](#input\_approved\_locations) | List of approved Azure locations for resource groups | `list(string)` | <pre>[<br>  "East US",<br>  "West Europe",<br>  "Southeast Asia"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the resource group |
| <a name="output_name"></a> [name](#output\_name) | The name of the resource group |
| <a name="output_location"></a> [location](#output\_location) | The location of the resource group |
| <a name="output_tags"></a> [tags](#output\_tags) | The tags applied to the resource group |

## Security Features

- **Resource Locks**: Prevent accidental deletion of critical resource groups
- **Policy Enforcement**: Custom policies for naming conventions, locations, and required tags
- **Audit Trail**: Comprehensive tagging for governance and compliance

## Examples

See the [examples](./examples/) directory for complete usage examples:

- [Basic Resource Group](./examples/basic-resource-group/)
- [Locked Resource Group](./examples/locked-resource-group/)

## Contributing

Please read our [contributing guidelines](../../CONTRIBUTING.md) before submitting pull requests.

## License

This module is licensed under the MIT License. See [LICENSE](../../LICENSE) for details.