variable "region" {
  type          = string
  default       = "eastus2"
  description   = "Region."
}

variable "resource_group_name" {
  type          = string
  default       = "poc-confluent-cloud"
  description   = "Resourve Group Name."
}
