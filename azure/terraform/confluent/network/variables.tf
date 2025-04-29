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

variable "confluent_api_key" {
  description   = "Confluent Cloud API Key"
  type          = string
}

variable "confluent_api_secret" {
  description   = "Confluent Cloud API Secret"
  type          = string
}
