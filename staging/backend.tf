#This file manage the provider and save the terraform state to azure blobe:

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "terraformbackend"
    storage_account_name = "terraform1daniel"
    container_name       = "tfstate"
    key                  = "staging/terraform.tfstate"
  }
}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = "West Europe"
}