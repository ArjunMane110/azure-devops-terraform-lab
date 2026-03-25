output "lb_id" {
  description = "ID of the Load Balancer"
  value       = azurerm_lb.this.id
}

output "lb_name" {
  description = "Name of the Load Balancer"
  value       = azurerm_lb.this.name
}

output "backend_pool_id" {
  description = "ID of the backend address pool"
  value       = azurerm_lb_backend_address_pool.this.id
}

output "frontend_ip" {
  description = "Frontend IP configuration name"
  value       = azurerm_lb.this.frontend_ip_configuration[0].private_ip_address
}