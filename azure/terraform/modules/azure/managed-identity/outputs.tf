output "id" {
  value = azurerm_user_assigned_identity.this.id
}

output "name" {
  value = azurerm_user_assigned_identity.this.name
}

output "client_id" {
  value = azurerm_user_assigned_identity.this.client_id
}

output "principal_id" {
  value = azurerm_user_assigned_identity.this.principal_id
}

output "tenant_id" {
  value = azurerm_user_assigned_identity.this.tenant_id
}
