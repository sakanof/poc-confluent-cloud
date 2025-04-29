output "id" {
  value = azuread_application.this.id
}

output "name" {
  value = azuread_application.this.display_name
}

output "object_id" {
  value = azuread_application.this.object_id
}

output "client_id" {
  value = azuread_application.this.client_id
}
