terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.26.0"
    }
    confluent = {
      source  = "confluentinc/confluent"
      version = "2.24.0"
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
