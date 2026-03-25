variable "lb_name" {
  description = "Name of the Load Balancer"
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

variable "subnet_id" {
  description = "Subnet ID for the Load Balancer frontend"
  type        = string
}

variable "environment" {
  description = "Environment tag"
  type        = string
}