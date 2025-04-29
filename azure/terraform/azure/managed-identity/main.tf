module "managed_identity" {
  source                = "../../modules/azure/managed-identity"

  name                  = "aks-kafka-consumer"
  region                = data.terraform_remote_state.resource_group.outputs.location
  resource_group_name   = data.terraform_remote_state.resource_group.outputs.name
}
