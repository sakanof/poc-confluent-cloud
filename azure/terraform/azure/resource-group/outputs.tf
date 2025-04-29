output "location" {
  value = module.resource_group.location
}

output "id" {
  value = module.resource_group.id
}

output "name" {
  value = module.resource_group.name
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}
