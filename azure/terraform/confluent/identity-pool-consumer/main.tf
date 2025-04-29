module "identity_pool" {
  source                = "../../modules/confluent/identity-pool"

  name                  = var.name
  identity_provider_id  = data.terraform_remote_state.identity_provider.outputs.id
  application_client_id = data.terraform_remote_state.application_registration.outputs.client_id
}
