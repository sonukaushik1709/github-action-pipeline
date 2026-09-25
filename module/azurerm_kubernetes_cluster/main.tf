resource "azurerm_kubernetes_cluster" "aks" {
  for_each = var.aksc

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}


output "client_certificate" {
  value = {
    for k, v in azurerm_kubernetes_cluster.aks :
    k => v.kube_config[0].client_certificate
  }
  sensitive = true
}


output "kube_config" {
  value = {
    for k, v in azurerm_kubernetes_cluster.aks :
    k => v.kube_config_raw
  }
  sensitive = true
}

variable "aksc" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = string
  }))
}
