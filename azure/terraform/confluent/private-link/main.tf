module "private_link" {
  source                = "../../modules/confluent/private-link"

  display_name          = "Azure Private Link Access"
  environment_id        = data.terraform_remote_state.confluent_environment.outputs.id
  network_id            = data.terraform_remote_state.network.outputs.id
  azure_subscription_id = var.azure_subscription_id
}
