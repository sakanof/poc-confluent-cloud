output "id" {
  description = "The ID of the created Azure Key Vault Key"
  value       = azurerm_key_vault_key.this.id
}

output "versionless_id" {
  description = "The versionless ID of the created Azure Key Vault Key"
  value       = azurerm_key_vault_key.this.versionless_id
}

output "resource_id" {
  description = "The Resource ID of the created Azure Key Vault Key"
  value       = azurerm_key_vault_key.this.resource_id
}

output "resource_versionless_id" {
  description = "The versionless Resource ID of the created Azure Key Vault Key"
  value       = azurerm_key_vault_key.this.resource_versionless_id
}
