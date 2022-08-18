terraform {

  required_version = ">=1.2.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>3.18.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.12.1"
    }


  }
}
