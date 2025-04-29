resource "confluent_byok_key" "this" {
  azure {
    tenant_id       = var.tenant_id
    key_vault_id    = var.vault_id
    key_identifier  = var.key_id
  }
}

# Create service principal referencing the application ID returned by the confluent cloud key
resource "azuread_service_principal" "this" {
  client_id                     = confluent_byok_key.this.azure[0].application_id
  app_role_assignment_required  = false
  owners                        = [var.object_id]

  depends_on = [confluent_byok_key.this]
}

# Create role assignments to the service principal to allow Confluent access to the keyvault
resource "azurerm_role_assignment" "reader_role_assignment" {
  scope                = var.vault_id

  role_definition_name = "Key Vault Reader"
  principal_id         = azuread_service_principal.this.object_id

  depends_on = [azuread_service_principal.this]
}

resource "azurerm_role_assignment" "encryption_user_role_assignment" {
  scope                 = var.vault_id

  role_definition_name  = "Key Vault Crypto Service Encryption User"
  principal_id          = azuread_service_principal.this.object_id

  depends_on            = [azuread_service_principal.this]
}
