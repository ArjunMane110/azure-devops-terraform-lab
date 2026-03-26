output "vmss_id" {
  description = "ID of the VM Scale Set"
  value       = azurerm_windows_virtual_machine_scale_set.this.id
}

output "vmss_name" {
  description = "Name of the VM Scale Set"
  value       = azurerm_windows_virtual_machine_scale_set.this.name
}

output "instance_count" {
  description = "Number of instances in the Scale Set"
  value       = azurerm_windows_virtual_machine_scale_set.this.instances
}