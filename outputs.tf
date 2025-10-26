output "id" {
  description = "The ID of the resource group"
  value       = var.create_resource_group ? azurerm_resource_group.this[0].id : null
}

output "name" {
  description = "The name of the resource group"
  value       = var.name
}

output "location" {
  description = "The location of the resource group"
  value       = var.location
}

output "tags" {
  description = "The tags applied to the resource group"
  value       = local.tags
}