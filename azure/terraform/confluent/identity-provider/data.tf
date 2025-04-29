data "terraform_remote_state" "app_registration" {
  backend = "local"
  config = {
    path = "../../azure/app-registration/terraform.tfstate"
  }
}

data "terraform_remote_state" "resource_group" {
  backend = "local"
  config = {
    path = "../../azure/resource-group/terraform.tfstate"
  }
}
