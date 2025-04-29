module "topic" {
  source        = "../../modules/confluent/identity-pool-permission"

  principal     = "User:${data.terraform_remote_state.identity_pool.outputs.id}"
  role_name     = "DeveloperRead"
  crn_pattern   = "${data.terraform_remote_state.kafka_cluster.outputs.cluster_rbac_crn}/kafka=${data.terraform_remote_state.kafka_cluster.outputs.cluster_id}/topic=*"
}

module "consumer_group" {
  source        = "../../modules/confluent/identity-pool-permission"

  principal     = "User:${data.terraform_remote_state.identity_pool.outputs.id}"
  role_name     = "DeveloperRead"
  crn_pattern   = "${data.terraform_remote_state.kafka_cluster.outputs.cluster_rbac_crn}/kafka=${data.terraform_remote_state.kafka_cluster.outputs.cluster_id}/group=*"
}
