module "application" {
  source            = "../../modules/azure/app-registration/"

  application_name  = "kafka-client-app"
}
