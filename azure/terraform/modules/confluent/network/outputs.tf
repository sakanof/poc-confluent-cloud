output "network" {
  description = "Confluent Network"
  value       = confluent_network.this
}

output "id" {
  description = "The ID of the created Confluent Network"
  value       = confluent_network.this.id
}

output "private_link_service_aliases" {
  description = "Confluent Private Link"
  value       = confluent_network.this.azure[0].private_link_service_aliases
}

output "dns_domain" {
  description = "DNS Domain"
  value       = confluent_network.this.dns_domain
}
