# export KUBE_CONFIG_PATH=/path/to/.kube/config
# $env:KUBE_CONFIG_PATH=/path/to/.kube/config

resource "helm_release" "ingress" {
    depends_on = [
      azurerm_kubernetes_cluster.k8s
    ]
    name  = lower("${var.name}-ingress")
    chart = "ingress-nginx"
    repository = "./charts"
    namespace = "default"
    wait = false
    create_namespace = true

#    set {
#        name = "controller.service.loadBalancerIP"
#        value = azurerm_public_ip.public_ip.ip_address
#    }

    set {
        name = "controller.scope.enabled"
        value = true
    }

    set {
        name  = "nodeSelector.app"
        value = "ingress"
    }

}
