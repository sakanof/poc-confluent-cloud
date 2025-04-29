module "federated_managed_credential" {
  source                            = "../../modules/azure/federated-managed-identity"

  name                              = "${data.terraform_remote_state.managed_identity.outputs.name}-federated-credential"
  resource_group_name               = data.terraform_remote_state.resource_group.outputs.name
  oidc_issuer_url                   = data.terraform_remote_state.aks.outputs.oidc_issuer_url
  managed_identity_id               = data.terraform_remote_state.managed_identity.outputs.id
  kubernetes_namespace              = var.kubernetes_namespace
  kubernetes_service_account_name   = var.kubernetes_service_account_name
}
