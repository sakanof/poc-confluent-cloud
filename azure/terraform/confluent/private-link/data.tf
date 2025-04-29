data "terraform_remote_state" "confluent_environment" {
  backend = "local"
  config = {
    path = "../environment/terraform.tfstate"
  }
}

data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../network/terraform.tfstate"
  }
}
