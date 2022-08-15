resource "azurerm_kubernetes_cluster" "k8s" {
    depends_on = [
      azurerm_resource_group.k8s
    ]

    timeouts {
        create = "20m"
        delete = "20m"
    }

    name                    = var.name
    location                = azurerm_resource_group.k8s.location
    resource_group_name     = local.resourcegroupname
    dns_prefix              = var.dns_prefix
    kubernetes_version      = var.orchestrator_version

    default_node_pool {
        name            = local.nodepoolname
        node_count      = 2
        vm_size         = "Standard_D4s_v3"
        orchestrator_version    = var.orchestrator_version
    }

    network_profile {
        load_balancer_sku = "basic"
        network_plugin = "kubenet"
    }

    identity {
        type = "SystemAssigned"
    }

    provisioner "local-exec" {
      command = local.command
    }

    tags = var.tags
}
