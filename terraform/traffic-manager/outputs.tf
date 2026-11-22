output "traffic_manager_fqdn" {
  value = azurerm_traffic_manager_profile.hybrid.fqdn
}

output "traffic_manager_resource_group" {
  value = azurerm_resource_group.traffic_manager.name
}
