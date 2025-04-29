module "environment" {
  source                    = "../../modules/confluent/environment"

  environment_display_name  = var.name
}
