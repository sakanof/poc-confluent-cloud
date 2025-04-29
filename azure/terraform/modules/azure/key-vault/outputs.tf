output "id" {
  description = "The ID of the created Azure Key Vault"
  value       = azurerm_key_vault.this.id
}

output "vault_uri" {
  description = "The URI of the created Azure Key Vault"
  value       = azurerm_key_vault.this.vault_uri
}

output "vault" {
  description = "The versionless Resource ID of the created Azure Key Vault Key"
  value       = azurerm_key_vault.this
}
