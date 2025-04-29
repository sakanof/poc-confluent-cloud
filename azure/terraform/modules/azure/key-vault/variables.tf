variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "region" {
  description = "Azure region where resources will be deployed"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "object_id" {
  description = "Azure Object ID"
  type        = string
}

variable "name" {
  description = "Name of the Key Vault"
  type        = string
}
