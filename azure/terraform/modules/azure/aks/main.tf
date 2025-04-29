resource "azurerm_user_assigned_identity" "this" {
  name                = "identity-${var.cluster_name}"
  location            = var.region
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "this" {
  scope                = var.resource_group_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}

resource "azurerm_kubernetes_cluster" "this" {
  name                      = "${var.cluster_name}"
  location                  = var.region
  resource_group_name       = var.resource_group_name
  dns_prefix                = var.dns_prefix

  kubernetes_version        = var.k8s_version
  automatic_upgrade_channel = "stable" # Version 4.x.x
  private_cluster_enabled   = false
  node_resource_group       = "node-${var.cluster_name}"

  # It's in Preview
  # api_server_access_profile {
  #   vnet_integration_enabled = true
  #   subnet_id                = azurerm_subnet.subnet1.id
  # }

  # For production change to "Standard"
  sku_tier = "Free"

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  network_profile {
    network_plugin = "azure"
    dns_service_ip = var.dns_service_ip
    service_cidr   = var.service_cidr
  }

  default_node_pool {
    name                 = "general"
    vm_size              = var.vm_size
    vnet_subnet_id       = var.subnet_id # azurerm_subnet.subnet1.id
    orchestrator_version = var.k8s_version
    type                 = "VirtualMachineScaleSets"
    auto_scaling_enabled = true # Version 4.x.
    node_count           = 1
    min_count            = 1
    max_count            = 10

    node_labels = {
      role = "general"
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }

  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }

  depends_on = [
    azurerm_user_assigned_identity.this,
    azurerm_role_assignment.this
  ]
}
