variable "name" {
  description   = "Name of the Federated Managed Identity."
  type          = string
}

variable "resource_group_name" {
  description   = "Resource Group Name."
  type          = string
}

variable "oidc_issuer_url" {
  description   = "OIDC Issuer URL."
  type          = string
}

variable "managed_identity_id" {
  description   = "Managed Identity ID."
  type          = string
}

variable "kubernetes_namespace" {
  description   = "Namespace of the Kubernetes Service Account"
  type          = string
}

variable "kubernetes_service_account_name" {
  description   = "Name of the Kubernetes Service Account"
  type          = string
}
