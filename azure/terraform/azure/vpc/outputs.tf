output "vnet_name" {
  description = "The ID of the created Virtual Network"
  value       = module.vpc.name
}

output "vnet_id" {
  description = "The ID of the created Virtual Network"
  value       = module.vpc.vnet_id
}

output "subnet_id" {
  description = "The ID of the created subnet"
  value       = module.vpc.subnet_id
}

