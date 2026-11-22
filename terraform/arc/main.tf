resource "azurerm_arc_kubernetes_cluster" "onprem" {
  name                         = "arc-mavencrest-onprem"
  resource_group_name          = "rg-arc-kubernetes"
  location                     = "eastus"
  agent_public_key_certificate = var.agent_public_key_certificate

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
  prevent_destroy = true

  ignore_changes = [
    agent_public_key_certificate
   ]
  }
}
