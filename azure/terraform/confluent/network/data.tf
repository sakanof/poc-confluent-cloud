data "terraform_remote_state" "confluent_environment" {
  backend = "local"
  config = {
    path = "../environment/terraform.tfstate"
  }
}
