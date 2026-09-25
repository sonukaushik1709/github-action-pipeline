terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.57.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "d4de6480-0ae2-4f72-b738-fd3b3b705bde"
}