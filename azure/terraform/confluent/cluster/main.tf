data "azurerm_client_config" "current" {}

module "cluster" {
  source            = "../../modules/confluent/cluster"

  cluster_name      = "test-aks"
  availability      = "SINGLE_ZONE"
  region            = var.region
  environment_id    = data.terraform_remote_state.confluent_environment.outputs.id
  network_id        = data.terraform_remote_state.network.outputs.id
  byok_key_id       = data.terraform_remote_state.byok.outputs.id
}
