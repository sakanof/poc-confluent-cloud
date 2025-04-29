data "terraform_remote_state" "resource_group" {
  backend = "local"
  config = {
    path = "../resource-group/terraform.tfstate"
  }
}

data "terraform_remote_state" "aks" {
  backend = "local"
  config = {
    path = "../aks/terraform.tfstate"
  }
}

data "terraform_remote_state" "managed_identity" {
  backend = "local"
  config = {
    path = "../managed-identity/terraform.tfstate"
  }
}
