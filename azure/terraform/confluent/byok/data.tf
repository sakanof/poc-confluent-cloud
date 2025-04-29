data "terraform_remote_state" "azure_key_vault" {
  backend = "local"
  config = {
    path = "../../azure/key-vault/terraform.tfstate"
  }
}

data "terraform_remote_state" "azure_key_vault_key" {
  backend = "local"
  config = {
    path = "../../azure/key-vault-key/terraform.tfstate"
  }
}
