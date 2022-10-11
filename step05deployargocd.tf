resource "kubernetes_namespace" "argocd" {
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
  metadata {
    annotations = {
      name = "argo"
    }

    labels = {
      mylabel = "argo"
    }

    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
  name  = "argocd"
  chart = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "5.5.18"
  namespace = "argocd"
  wait = false
  create_namespace = true
  set {
    name = "server.ingress.enabled"
    value = true
  }

  set {
    name = "server.ingress.hosts[0]"
    value = "argocd.test.zxyxy.net"
  }

  set {
    name = "server.ingress.ingressClassName"
    value = "nginx"
  }

  set {
    name = "server.extraArgs[0]"
    value = "--insecure"
  }
}

resource "helm_release" "argocd-events" {
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
  name       = "argocd-events"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-events"
  version    = "2.0.5"
  namespace  = "argocd"
  create_namespace = true
}
