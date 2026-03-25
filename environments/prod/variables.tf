variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnet_name" {
  type = string
}

variable "subnet_prefix" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "Standard_D2s_v3"
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "environment" {
  type = string
}

variable "create_public_ip" {
  type    = bool
  default = false
}

variable "storage_account_name" {
  type = string
}

variable "nsg_name" {
  type = string
}

variable "keyvault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "tenant_id" {
  type = string
}

variable "object_id" {
  type = string
}

variable "pipeline_object_id" {
  type = string
}

variable "log_analytics_name" {
  description = "Name of Log Analytics Workspace"
  type        = string
}

variable "lb_name" {
  description = "Name of the Load Balancer"
  type        = string
}