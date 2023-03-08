# Azure Provider source and version being used
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

# Main resource group
resource "azurerm_resource_group" "rg_main" {
  name     = var.resource_group
  location = var.location
  tags = {
    environment = "Terraform Lab"
  }
}

# Storage account
module "storage_account" {
  source         = "./modules/storage_account"
  acccount_name  = var.storage_account_name
  resource_group = azurerm_resource_group.rg_main
  container_envs = ["dev", "test", "prod"]
  tags = {
    environment = "Terraform Lab"
  }
}
