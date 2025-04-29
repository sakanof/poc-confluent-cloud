resource "azurerm_private_endpoint" "endpoint" {
  for_each = data.terraform_remote_state.confluent_network.outputs.private_link_service_aliases

  name                                  = "confluent-cloud-${each.key}"
  location                              = data.terraform_remote_state.resource_group.outputs.location
  resource_group_name                   = data.terraform_remote_state.resource_group.outputs.name

  subnet_id                             = data.terraform_remote_state.vpc.outputs.subnet_id

  private_service_connection {
    name                                = "confluent-${each.key}"
    is_manual_connection                = true
    private_connection_resource_alias   = each.value
    request_message                     = "PL"
  }
}

resource "azurerm_private_dns_zone" "hz" {
  resource_group_name   = data.terraform_remote_state.resource_group.outputs.name
  name                  = data.terraform_remote_state.confluent_network.outputs.dns_domain
}

resource "azurerm_private_dns_zone_virtual_network_link" "hz" {
  name                  = data.terraform_remote_state.vpc.outputs.vnet_name
  resource_group_name   = data.terraform_remote_state.resource_group.outputs.name
  private_dns_zone_name = azurerm_private_dns_zone.hz.name
  virtual_network_id    = data.terraform_remote_state.vpc.outputs.vnet_id
}

resource "azurerm_private_dns_a_record" "rr" {
  name                = "*"
  zone_name           = azurerm_private_dns_zone.hz.name
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name
  ttl                 = 60
  records             = [
    for _, ep in azurerm_private_endpoint.endpoint: ep.private_service_connection[0].private_ip_address
  ]

  depends_on = [azurerm_private_endpoint.endpoint]
}

resource "azurerm_private_dns_a_record" "zonal" {
  for_each = data.terraform_remote_state.confluent_network.outputs.private_link_service_aliases

  name                = "*.az${each.key}"
  zone_name           = azurerm_private_dns_zone.hz.name
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name
  ttl                 = 60
  records             = [
    azurerm_private_endpoint.endpoint[each.key].private_service_connection[0].private_ip_address,
  ]
}
