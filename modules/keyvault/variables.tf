variable "keyvault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "environment" {
  description = "Environment tag"
  type        = string
}

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}

variable "object_id" {
  description = "Object ID of the user to grant access"
  type        = string
}

variable "pipeline_object_id" {
  description = "Object ID of the pipeline service principal"
  type        = string
}

variable "vm_admin_password" {
  description = "VM admin password to store in Key Vault"
  type        = string
  sensitive   = true
}