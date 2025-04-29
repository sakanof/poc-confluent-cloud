variable "cluster_name" {
  description = "Display name for the Confluent Kafka Cluster"
  type        = string
}

variable "availability" {
  description = "Kafka cluster availability (SINGLE_ZONE or MULTI_ZONE)."
  type        = string
}

variable "region" {
  description = "Region for the Confluent Cloud network."
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

variable "byok_key_id" {
  type        = string
}
