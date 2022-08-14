variable "location" { type = string }
variable "name" { type = string}
variable "dns_prefix" { type = string}
variable "env" {
  type = string
  description = "Purpose of the deployment like live or test"
}
variable "orchestrator_version" {
  type = string
  description = "The version of the nodes in the kubernetes cluster"
}
