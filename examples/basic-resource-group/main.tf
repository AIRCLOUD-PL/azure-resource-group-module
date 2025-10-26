# Basic Resource Group Example
# This example demonstrates how to create a basic Azure Resource Group

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Azure Resource Group Module
module "resource_group" {
  source = "../../"

  name     = "rg-example-basic"
  location = "East US 2"

  tags = {
    Environment = "example"
    Project     = "resource-group-demo"
    Owner       = "platform-team"
    CreatedBy   = "terraform"
  }

  enable_resource_lock = false
}

# Outputs
output "resource_group_id" {
  description = "The ID of the Resource Group"
  value       = module.resource_group.id
}

output "resource_group_name" {
  description = "The name of the Resource Group"
  value       = module.resource_group.name
}

output "resource_group_location" {
  description = "The location of the Resource Group"
  value       = module.resource_group.location
}

output "resource_group_tags" {
  description = "The tags applied to the Resource Group"
  value       = module.resource_group.tags
}