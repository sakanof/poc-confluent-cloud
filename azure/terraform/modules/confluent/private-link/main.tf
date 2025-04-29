resource "confluent_private_link_access" "this" {
  display_name = var.display_name

  environment {
    id = var.environment_id
  }

  network {
    id = var.network_id
  }

  azure {
    subscription = var.azure_subscription_id
  }

  # lifecycle {
  #   prevent_destroy = true
  # }
}
