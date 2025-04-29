output "id" {
  description = "The ID of the created Confluent environment"
  value       = module.environment.id
}

output "display_name" {
  description = "Confluent Environment Name"
  value       = module.environment.display_name
}

output "resource_name" {
  description = "Confluent Environment Resource Name (crn)"
  value       = module.environment.resource_name
}
