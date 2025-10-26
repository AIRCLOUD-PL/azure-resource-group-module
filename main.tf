# Azure Resource Group Module
# Creates enterprise-grade Azure Resource Groups with governance and security features

# Data sources
data "azurerm_client_config" "current" {}

# Local values
locals {
  # Default tags
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "azure-resource-group"
    CreatedBy = data.azurerm_client_config.current.client_id
    CreatedOn = timestamp()
  }

  tags = merge(local.default_tags, var.tags)
}

# Resource Group
resource "azurerm_resource_group" "this" {
  count = var.create_resource_group ? 1 : 0

  name     = var.name
  location = var.location

  tags = local.tags
}

# Resource Lock
resource "azurerm_management_lock" "this" {
  count = var.enable_resource_lock && var.create_resource_group ? 1 : 0

  name       = "${var.name}-lock"
  scope      = azurerm_resource_group.this[0].id
  lock_level = var.lock_level
  notes      = "Resource lock for Resource Group ${var.name}"
}