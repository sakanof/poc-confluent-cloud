variable "kubernetes_namespace" {
  description   = "Namespace of the Kubernetes Service Account"
  default       = "poc-aws-msk"
  type          = string
}

variable "kubernetes_service_account_name" {
  description   = "Name of the Kubernetes Service Account"
  default       = "read-sa"
  type          = string
}

variable "azure_subscription_id" {
  description   = "Azure Subscription ID for Confluent Private Link"
  type          = string
}
