# helm repo update

resource "helm_release" "webserver" {
  depends_on = [
    helm_release.ingress
  ]
  name       = "webserver"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "apache"
  verify     = false
  version    = "9.1.18"

  set {
    name  = "ingress.enabled"
    value = true
  }

  set {
    name = "ingress.ingressClassName"
    value = "ingress"
  }

  set {
    name = "ingress.hostname"
    value = var.hostname
  }

  set {
    name = "ingress.path"
    value = "/"
  }

  set {
    name = "ingress.hosts[0].name"
    value = var.hostname
  }

  set {
    name = "ingress.hosts[0].paths[0]"
    value = "/"
  }

  set {
    name = "service.type"
    value = "ClusterIP"
  }
}
