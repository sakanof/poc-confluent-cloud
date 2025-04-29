variable "name" {
  description   = "Name of the Key Vault"
  default       = "poc-aks-dev"
  type          = string
}

variable "azure_subscription_id" {
  description   = "Azure Subscription ID for Confluent Private Link"
  type          = string
}
