variable "name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where the resource group will be created"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the resource group"
  type        = map(string)
  default     = {}
}

variable "create_resource_group" {
  description = "Whether to create the resource group"
  type        = bool
  default     = true
}

variable "enable_resource_lock" {
  description = "Enable resource lock for the resource group"
  type        = bool
  default     = false
}

variable "lock_level" {
  description = "Resource lock level: CanNotDelete or ReadOnly"
  type        = string
  default     = "CanNotDelete"
  validation {
    condition     = contains(["CanNotDelete", "ReadOnly"], var.lock_level)
    error_message = "Lock level must be CanNotDelete or ReadOnly."
  }
}

variable "create_custom_policies" {
  description = "Create custom Azure Policy definitions for resource groups"
  type        = bool
  default     = false
}

variable "approved_locations" {
  description = "List of approved Azure locations for resource groups"
  type        = list(string)
  default     = ["East US", "West Europe", "Southeast Asia"]
}