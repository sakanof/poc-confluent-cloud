variable "name" {
  description   = "Name of the Key"
  default       = "confluent-cloud-cluster"
  type          = string
}

variable "azure_subscription_id" {
  description   = "Azure Subscription ID for Confluent Private Link"
  type          = string
}
