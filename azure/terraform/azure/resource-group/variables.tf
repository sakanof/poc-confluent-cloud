variable "environment" {
  description   = "Environment"
  default       = "dev"
  type          = string
}

variable "region" {
  description   = "Azure region where resources will be deployed"
  default       = "eastus2"
  type          = string
}

variable "azure_subscription_id" {
  description   = "Azure Subscription ID for Confluent Private Link"
  type          = string
}
