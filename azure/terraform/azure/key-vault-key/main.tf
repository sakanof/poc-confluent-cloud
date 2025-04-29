resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

module "key_vault_key" {
  source        = "../../modules/azure/key-vault-key"

  key_name      = "${var.name}-${random_string.suffix.result}"
  key_vault_id  = data.terraform_remote_state.key_vault.outputs.id
}
