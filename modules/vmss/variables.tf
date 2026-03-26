variable "vmss_name" {
  description = "Name of the VM Scale Set"
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

variable "vm_size" {
  description = "Size of the VM instances"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "instance_count" {
  description = "Number of VM instances"
  type        = number
  default     = 1
}

variable "admin_username" {
  description = "Admin username"
  type        = string
}

variable "admin_password" {
  description = "Admin password"
  type        = string
  sensitive   = true
}

variable "subnet_id" {
  description = "Subnet ID to attach VMSS"
  type        = string
}

variable "backend_pool_id" {
  description = "Load balancer backend pool ID"
  type        = string
}

variable "environment" {
  description = "Environment tag"
  type        = string
}

variable "computer_name_prefix" {
  description = "Computer name prefix for VMSS instances (max 9 chars)"
  type        = string
}