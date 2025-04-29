output "aks_cluster_id" {
  description = "The ID of the created AKS cluster"
  value       = module.aks.aks_cluster_id
}

output "kube_config" {
  description = "Kubeconfig to access the AKS cluster"
  value       = module.aks.kube_config
  sensitive   = true
}

output "oidc_issuer_url" {
  value       = module.aks.oidc_issuer_url
}
