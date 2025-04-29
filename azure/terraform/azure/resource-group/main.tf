data "azurerm_client_config" "current" {}

module "resource_group" {
  source                = "../../modules/azure/resource-group"

  resource_group_name   = "poc-aks-${var.environment}"
  region                = var.region
}
