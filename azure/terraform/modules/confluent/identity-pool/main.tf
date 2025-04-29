resource "confluent_identity_pool" "this" {
  identity_provider {
    id = var.identity_provider_id
  }

  display_name      = var.name
  identity_claim    = "claims.sub"
  filter            = "claims.aud==\"${var.application_client_id}\""
  description       = "asdasd"
}
