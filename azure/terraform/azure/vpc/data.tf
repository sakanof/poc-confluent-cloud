data "terraform_remote_state" "resource_group" {
  backend = "local"
  config = {
    path = "../resource-group/terraform.tfstate"
  }
}
