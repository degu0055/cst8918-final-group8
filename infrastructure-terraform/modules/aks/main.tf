resource "azurerm_kubernetes_cluster" "aks" {
  name                = "cst8918-${var.environment}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "cst8918-${var.environment}-aks"

  default_node_pool {
    name       = "default"
    vm_size    = var.vm_size

    # Use fixed node count for non-prod, and min_count for prod (no autoscaling here)
    node_count = var.environment == "prod" ? var.min_count : var.node_count
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = var.kubernetes_version

  network_profile {
    network_plugin = "azure"
  }

  tags = {
    environment = var.environment
    project     = "cst8918-final-project"
  }
}
