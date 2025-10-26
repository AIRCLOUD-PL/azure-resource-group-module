# Basic Resource Group Example

This example demonstrates how to create a basic Azure Resource Group with proper tagging and governance.

## Overview

This example creates:
- A resource group with proper naming convention
- Comprehensive tagging for governance
- Basic configuration without resource locks

## Architecture

```
Subscription
    └── Resource Group (rg-example-basic)
        ├── Location: East US 2
        └── Tags: Environment, Project, Owner, CreatedBy
```

## Usage

1. Navigate to this directory:
   ```bash
   cd examples/basic-resource-group
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the plan:
   ```bash
   terraform plan
   ```

4. Apply the configuration:
   ```bash
   terraform apply
   ```

5. Clean up when done:
   ```bash
   terraform destroy
   ```

## Configuration

The resource group is configured with:
- **Naming**: Follows `rg-{purpose}-{environment}` convention
- **Location**: East US 2 region
- **Tags**: Environment, Project, Owner, and CreatedBy tags
- **Locks**: Disabled for this basic example

## Governance Features

- Consistent naming convention
- Required tagging for resource management
- Audit trail through tagging

## Outputs

- `resource_group_id`: The resource ID of the Resource Group
- `resource_group_name`: The name of the Resource Group
- `resource_group_location`: The Azure region
- `resource_group_tags`: All applied tags

## Next Steps

- Explore the [locked resource group example](../locked-resource-group/) for protection against accidental deletion
- Review the main module [README](../../README.md) for all available options
- Consider using this as a foundation for other Azure resources