module "aks" {
  source                = "../../modules/azure/aks"

  resource_group_name   = data.terraform_remote_state.resource_group.outputs.name
  resource_group_id     = data.terraform_remote_state.resource_group.outputs.id
  cluster_name          = "${var.cluster_name}-${var.environment}"
  region                = var.region
  dns_prefix            = "${var.cluster_name}"
  subnet_id             = data.terraform_remote_state.vpc.outputs.subnet_id
}
