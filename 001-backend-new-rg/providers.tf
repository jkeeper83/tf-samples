terraform {

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.30.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.41.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.7.1"
    }
    local = {
      source = "hashicorp/local"
      version = ">=2.3.0"
    }
  }
  required_version = ">= 1.3.7"
}

provider "azurerm" { #
  subscription_id = var.provider_subscription_id
  client_id       = var.provider_client_id
  client_secret   = var.provider_client_secret
  tenant_id       = var.provider_tenant_id

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
