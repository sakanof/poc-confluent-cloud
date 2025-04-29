data "terraform_remote_state" "identity_pool" {
  backend = "local"
  config = {
    path = "../identity-pool-topic-owner/terraform.tfstate"
  }
}

data "terraform_remote_state" "kafka_cluster" {
  backend = "local"
  config = {
    path = "../cluster/terraform.tfstate"
  }
}
