output "id" {
  description = "The ID of the created Azure Key Vault"
  value       = module.key_vault.id
}

output "vault_uri" {
  description = "The URI of the created Azure Key Vault"
  value       = module.key_vault.vault_uri
}

output "vault" {
  description = "The versionless Resource ID of the created Azure Key Vault Key"
  value       = module.key_vault.vault
}
