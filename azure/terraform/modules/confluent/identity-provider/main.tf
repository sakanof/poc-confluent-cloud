resource "confluent_identity_provider" "this" {
  display_name  = var.name
  issuer        = "https://login.microsoftonline.com/${var.tenant_id}/v2.0"
  jwks_uri      = "https://login.microsoftonline.com/${var.tenant_id}/discovery/keys?appid=${var.application_client_id}"
  description   = var.description
}
