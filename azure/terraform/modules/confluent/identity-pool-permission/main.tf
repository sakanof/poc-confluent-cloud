resource "confluent_role_binding" "this" {
  principal     = var.principal
  role_name     = var.role_name
  crn_pattern   = var.crn_pattern
}
