output "vm_id" {
  description = "ID of the Virtual Machine"
  value       = azurerm_windows_virtual_machine.win-vm.id
}

output "vm_name" {
  description = "Name of the Virtual Machine"
  value       = azurerm_windows_virtual_machine.win-vm.name
}

output "private_ip" {
  description = "Private IP of the VM"
  value       = azurerm_network_interface.this.private_ip_address
}

output "public_ip" {
  description = "Public IP of the VM"
  value       = var.create_public_ip ? azurerm_public_ip.this[0].ip_address : null
}