terraform {
  required_version = ">=1.0"
  # Make sure to configure a backend to save the state
  # backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~>1.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azapi" {
}
