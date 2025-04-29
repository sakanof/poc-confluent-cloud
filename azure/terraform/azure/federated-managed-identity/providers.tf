terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "2.24.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.26.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      # version = "~> 2.15.0"
    }
  }
  #required_version = ">= 1.3.0"
}

provider "confluent" {
  cloud_api_key    = var.confluent_api_key
  cloud_api_secret = var.confluent_api_secret
}

provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}

# provider "azuread" {
#   subscription_id = var.azure_subscription_id
# }
