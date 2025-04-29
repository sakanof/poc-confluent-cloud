module "network" {
  source            = "../../modules/confluent/network"

  display_name      = "network-${var.environment}"
  region            = var.region
  environment_id    = data.terraform_remote_state.confluent_environment.outputs.id
}
