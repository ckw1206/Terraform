terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}


module "AzCompute" {
  source = "git::https://github.com/Azure/terraform-azurerm-compute.git"
  
}

module "AzNetwork" {
  source = "git::https://github.com/Azure/terraform-azurerm-network.git"
  
}