data "terraform_remote_state" "key_vault" {
  backend = "local"
  config = {
    path = "../key-vault/terraform.tfstate"
  }
}
