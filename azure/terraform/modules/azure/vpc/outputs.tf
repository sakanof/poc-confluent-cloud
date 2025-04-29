output "name" {
  description = "The ID of the created Virtual Network"
  value       = azurerm_virtual_network.this.name
}

output "vnet_id" {
  description = "The ID of the created Virtual Network"
  value       = azurerm_virtual_network.this.id
}

output "subnet_id" {
  description = "The ID of the created subnet"
  value       = azurerm_subnet.this.id
}
