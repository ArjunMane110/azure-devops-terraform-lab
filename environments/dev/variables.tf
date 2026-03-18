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
  description = "Whether to create a public IP"
  type        = bool
  default     = false
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "nsg_name" {
  description = "Name of the NSG"
  type        = string
}

variable "kv_name" {
  description = "Name of the Key Vault"
  type        = string
}