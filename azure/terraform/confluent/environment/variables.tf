variable "name" {
  description   = "Environment Name"
  default       = "dev"
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
