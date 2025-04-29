module "vpc" {
  source                = "../../modules/azure/vpc"

  resource_group_name   = data.terraform_remote_state.resource_group.outputs.name
  region                = var.region

  vnet_name             = "aks-vnet-${var.environment}"
  address_space         = ["10.0.0.0/16"]

  subnet_name           = "aks-subnet-${var.environment}"
  subnet_prefixes       = ["10.0.1.0/24"]
}
