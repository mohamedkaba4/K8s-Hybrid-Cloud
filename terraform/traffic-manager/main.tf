resource "azurerm_resource_group" "traffic_manager" {
  name     = "rg-k8s-nexus-traffic-manager"
  location = "eastus"

  tags = {
    project     = "k8s-nexus"
    environment = "prod"
    managed_by  = "terraform"
  }
}

resource "azurerm_traffic_manager_profile" "hybrid" {
  name                   = "tm-k8s-nexus-hybrid"
  resource_group_name    = azurerm_resource_group.traffic_manager.name
  traffic_routing_method = "Priority"
  profile_status         = "Disabled"

  dns_config {
    relative_name = "tm-k8s-nexus-hybrid"
    ttl           = 30
  }

  monitor_config {
    protocol = "HTTPS"
    port     = 443
    path     = "/"
  }

  tags = azurerm_resource_group.traffic_manager.tags
}

resource "azurerm_traffic_manager_external_endpoint" "onprem" {
  name       = "onprem-primary"
  profile_id = azurerm_traffic_manager_profile.hybrid.id
  target     = "k8.mavencrest.shop"
  priority   = 1
  enabled    = false
}

resource "azurerm_traffic_manager_external_endpoint" "aks" {
  name       = "aks-secondary"
  profile_id = azurerm_traffic_manager_profile.hybrid.id
  target     = "aks.arc.mavencrest.site"
  priority   = 2
  enabled    = false
}
