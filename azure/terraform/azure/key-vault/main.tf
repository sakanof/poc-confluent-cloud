data "azurerm_client_config" "current" {}

module "key_vault" {
  source                = "../../modules/azure/key-vault"

  name                  = var.name
  region                = data.terraform_remote_state.resource_group.outputs.location
  resource_group_name   = data.terraform_remote_state.resource_group.outputs.name
  tenant_id             = data.azurerm_client_config.current.tenant_id
  object_id             = data.azurerm_client_config.current.object_id
}
