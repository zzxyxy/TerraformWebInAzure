resource "azurerm_resource_group" "k8s" {
  name      = local.resourcegroupname
  location  = var.location
}
