output "cluster" {
  value       = module.cluster.cluster
}

output "cluster_id" {
  value       = module.cluster.id
}

output "cluster_rbac_crn" {
  value       = module.cluster.cluster_rbac_crn
}

output "bootstrap_endpoint" {
  value       = module.cluster.bootstrap_endpoint
}
