variable "resource_group_id" {
  description = "ID of the Azure Resource Group"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "region" {
  description = "Azure region where resources will be deployed"
  type        = string
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description   = "DNS prefix for the AKS cluster"
  type          = string
  default       = "devaks1"
}

variable "vm_size" {
  description   = "VM Size."
  type          = string
  default       = "standard_a2_v2"
}

variable "dns_service_ip" {
  description   = "DNS Service IP."
  type          = string
  default       = "10.0.64.10"
}

variable "service_cidr" {
  description   = "Service CIDR."
  type          = string
  default       = "10.0.64.0/19"
}

variable "k8s_version" {
  description   = "K8s version."
  type          = string
  default       = "1.32"
}

variable "subnet_id" {
  description = "Subnet ID where the AKS cluster will be deployed"
  type        = string
}
