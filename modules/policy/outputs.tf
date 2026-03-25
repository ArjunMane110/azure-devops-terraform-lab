output "environment_tag_policy_id" {
  description = "ID of the environment tag policy assignment"
  value       = azurerm_resource_group_policy_assignment.require_environment_tag.id
}

output "managedby_tag_policy_id" {
  description = "ID of the ManagedBy tag policy assignment"
  value       = azurerm_resource_group_policy_assignment.require_managedby_tag.id
}