data "terraform_remote_state" "identity_provider" {
  backend = "local"
  config = {
    path = "../identity-provider/terraform.tfstate"
  }
}

data "terraform_remote_state" "application_registration" {
  backend = "local"
  config = {
    path = "../../azure/app-registration/terraform.tfstate"
  }
}
