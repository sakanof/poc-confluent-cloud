data "azurerm_client_config" "current" {}

module "byok" {
  source            = "../../modules/confluent/byok"

  tenant_id         = data.azurerm_client_config.current.tenant_id
  object_id         = data.azurerm_client_config.current.object_id

  vault_id          = data.terraform_remote_state.azure_key_vault.outputs.id
  key_id            = data.terraform_remote_state.azure_key_vault_key.outputs.versionless_id
}
