data "terraform_remote_state" "resource_group" {
  backend = "local"
  config = {
    path = "../resource-group/terraform.tfstate"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "confluent_network" {
  backend = "local"
  config = {
    path = "../../confluent/network/terraform.tfstate"
  }
}
