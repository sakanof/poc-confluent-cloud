output "id" {
  value       = confluent_byok_key.this.id
}

output "azure_application_id" {
  value       = confluent_byok_key.this.azure[0].application_id
}

output "azure_object_id" {
  value       = azuread_service_principal.this.object_id
}
