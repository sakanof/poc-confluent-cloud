output "id" {
  description = "Confluent Environment ID"
  value       = confluent_environment.this.id
}

output "display_name" {
  description = "Confluent Environment Name"
  value       = confluent_environment.this.display_name
}

output "resource_name" {
  description = "Confluent Environment Resource Name (crn)"
  value       = confluent_environment.this.resource_name
}
