resource "confluent_network" "this" {
  display_name      = var.display_name
  cloud             = "AZURE"
  region            = var.region
  connection_types  = ["PRIVATELINK"]

  dns_config {
    resolution = "PRIVATE"
  }

  environment {
    id = var.environment_id
  }
}
