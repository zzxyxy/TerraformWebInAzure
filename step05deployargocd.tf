resource "kubernetes_namespace" "argocd" {
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

data "http" "crd" {
  url = "https://raw.githubusercontent.com/argoproj/argo-cd/master/manifests/crds/application-crd.yaml"
  request_headers = {
    Accept = "text/plain"
  }
}

locals {
  yamls = [for data in split("---", data.http.crd.body): yamldecode(data)]
}

resource "kubernetes_manifest" "install-crd" {
  count = length(local.yamls)
  manifest = local.yamls[count.index]
}

resource "helm_release" "argocd" {
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
  name       = "argocd"

  repository = "./charts"
  chart      = "argo-cd"
  version    = "2.11.0"
  namespace  = "argocd"
  create_namespace = true
}
