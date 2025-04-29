resource "azurerm_federated_identity_credential" "this" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  audience              = ["api://AzureADTokenExchange"]
  issuer                = var.oidc_issuer_url
  parent_id             = var.managed_identity_id
  subject               = "system:serviceaccount:${var.kubernetes_namespace}:${var.kubernetes_service_account_name}"
}
