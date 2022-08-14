resource "azurerm_public_ip" "fixip" {
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
  resource_group_name = azurerm_kubernetes_cluster.k8s.node_resource_group
  name = var.name
  location = var.location
  sku = "Basic"
  allocation_method = "Static"
}
