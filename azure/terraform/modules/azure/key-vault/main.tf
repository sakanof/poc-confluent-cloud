resource "azurerm_key_vault" "this" {
  name                      = var.name
  location                  = var.region
  resource_group_name       = var.resource_group_name
  tenant_id                 = var.tenant_id
  sku_name                  = "standard"

  enable_rbac_authorization = true

  purge_protection_enabled  = true  # <-- this is mandatory for Confluent BYOK
}

resource "azurerm_role_assignment" "keyvault_admin" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = var.object_id

  depends_on           = [azurerm_key_vault.this]
}

# Grant Access to Confluent's Managed Identity
# resource "azurerm_key_vault_access_policy" "confluent" {
#   key_vault_id = azurerm_key_vault.this.id
#
#   tenant_id = data.azurerm_client_config.current.tenant_id # var.confluent_tenant_id # <-- Tenant ID of Confluent's identity
#   object_id = data.azurerm_client_config.current.object_id # var.confluent_object_id # <-- Object ID (UUID) of Confluent's managed identity
#
#   key_permissions = [
#     "Get",
#     "WrapKey",
#     "UnwrapKey",
#   ]
# }
