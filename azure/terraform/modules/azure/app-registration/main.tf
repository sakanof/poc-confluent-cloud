resource "azuread_application" "this" {
  display_name = var.application_name

  api {
      mapped_claims_enabled          = true
      requested_access_token_version = 2
  }
}
