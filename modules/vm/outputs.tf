output "vm_id" {
  description = "ID of the Virtual Machine"
  value       = azurerm_windows_virtual_machine.this.id
}

output "vm_name" {
  description = "Name of the Virtual Machine"
  value       = azurerm_windows_virtual_machine.this.name
}

output "private_ip" {
  description = "Private IP of the VM"
  value       = azurerm_network_interface.this.private_ip_address
}