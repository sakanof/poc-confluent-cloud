resource "confluent_kafka_cluster" "this" {
  display_name = var.cluster_name
  availability = var.availability
  region       = var.region
  cloud        = "AZURE"

  environment {
    id = var.environment_id
  }

  network {
    id = var.network_id
  }

  dedicated {
    cku = 1
  }

  byok_key {
    id = var.byok_key_id
  }
}
