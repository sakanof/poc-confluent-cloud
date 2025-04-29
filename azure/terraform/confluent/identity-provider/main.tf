module "identity_provider" {
  source                = "../../modules/confluent/identity-provider"

  name                  = var.name
  description           = var.name
  tenant_id             = data.terraform_remote_state.resource_group.outputs.tenant_id
  application_client_id = data.terraform_remote_state.app_registration.outputs.client_id
}
