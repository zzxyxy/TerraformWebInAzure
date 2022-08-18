locals {
    resourcegroupname = "${var.name}-${var.env}"
    nodepoolname = "${var.name}app"
    command = "az aks get-credentials --resource-group ${local.resourcegroupname} --name ${var.name}"
    argocdpath = "argocd.${var.hostname}"
}
