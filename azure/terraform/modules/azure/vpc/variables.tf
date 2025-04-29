variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "region" {
  description = "Azure region where resources will be deployed"
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "address_space" {
  description = "List of CIDR blocks for the Virtual Network"
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the subnet for AKS nodes"
  type        = string
}

variable "subnet_prefixes" {
  description = "List of CIDR blocks for the subnet"
  type        = list(string)
}
