output "cluster" {
  description = "Kafka Cluster"
  value       = confluent_kafka_cluster.this
}

output "id" {
  description = "Kafka Cluster ID"
  value       = confluent_kafka_cluster.this.id
}

output "cluster_rbac_crn" {
  value       = confluent_kafka_cluster.this.rbac_crn
}

output "bootstrap_endpoint" {
  description = "Kafka Cluster"
  value       = confluent_kafka_cluster.this.bootstrap_endpoint
}
