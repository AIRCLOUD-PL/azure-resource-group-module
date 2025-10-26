# Azure Policy Definitions for Resource Groups
# This file contains Azure Policy definitions to enforce governance for Resource Groups

# Custom Policy Definition for Resource Group Naming
resource "azurerm_policy_definition" "resource_group_naming" {
  count = var.create_custom_policies ? 1 : 0

  name         = "resource-group-naming-convention"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Resource Groups should follow naming convention"

  policy_rule = jsonencode({
    if = {
      field  = "type"
      equals = "Microsoft.Resources/subscriptions/resourceGroups"
    }
    then = {
      effect = "Audit"
      details = {
        type = "Microsoft.Resources/subscriptions/resourceGroups"
        existenceCondition = {
          field = "name"
          match = "rg-*"
        }
      }
    }
  })

  metadata = jsonencode({
    category = "General"
  })
}

# Custom Policy Definition for Resource Group Location
resource "azurerm_policy_definition" "resource_group_location" {
  count = var.create_custom_policies ? 1 : 0

  name         = "resource-group-approved-locations"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Resource Groups should be created in approved locations"

  policy_rule = jsonencode({
    if = {
      field  = "type"
      equals = "Microsoft.Resources/subscriptions/resourceGroups"
    }
    then = {
      effect = "Audit"
      details = {
        type = "Microsoft.Resources/subscriptions/resourceGroups"
        existenceCondition = {
          field = "location"
          in    = var.approved_locations
        }
      }
    }
  })

  metadata = jsonencode({
    category = "General"
  })
}

# Custom Policy Definition for Resource Group Tags
resource "azurerm_policy_definition" "resource_group_required_tags" {
  count = var.create_custom_policies ? 1 : 0

  name         = "resource-group-required-tags"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Resource Groups should have required tags"

  policy_rule = jsonencode({
    if = {
      field  = "type"
      equals = "Microsoft.Resources/subscriptions/resourceGroups"
    }
    then = {
      effect = "Audit"
      details = {
        type = "Microsoft.Resources/subscriptions/resourceGroups"
        existenceCondition = {
          allOf = [
            {
              field  = "tags.Environment"
              exists = true
            },
            {
              field  = "tags.Project"
              exists = true
            }
          ]
        }
      }
    }
  })

  metadata = jsonencode({
    category = "Tags"
  })
}