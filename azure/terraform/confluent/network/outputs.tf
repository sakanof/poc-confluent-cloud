output "network" {
  description = "Confluent Network"
  value       = module.network.network
}

output "id" {
  description = "The ID of the created Confluent Network"
  value       = module.network.id
}

output "private_link_service_aliases" {
  description = "Confluent Private Link"
  value       = module.network.private_link_service_aliases
}

output "dns_domain" {
  description = "DNS Domain"
  value       = module.network.dns_domain
}
