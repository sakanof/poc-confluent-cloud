output "id" {
  description = "The ID of the created Azure Key Vault Key"
  value       = module.key_vault_key.id
}

output "versionless_id" {
  description = "The versionless ID of the created Azure Key Vault Key"
  value       = module.key_vault_key.versionless_id
}

output "resource_id" {
  description = "The Resource ID of the created Azure Key Vault Key"
  value       = module.key_vault_key.resource_id
}

output "resource_versionless_id" {
  description = "The versionless Resource ID of the created Azure Key Vault Key"
  value       = module.key_vault_key.resource_versionless_id
}
