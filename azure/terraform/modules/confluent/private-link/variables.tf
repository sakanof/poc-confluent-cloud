variable "display_name" {
  description = "Display Name of the Private Link"
  type        = string
}

variable "environment_id" {
  description = "ID of Confluent Environment."
  type        = string
}

variable "network_id" {
  description = "ID of Confluent Network."
  type        = string
}
variable "azure_subscription_id" {
  description = "Azure Subscription ID for Private Link access"
  type        = string
}
