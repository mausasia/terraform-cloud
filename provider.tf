### Definir versión de terraform

terraform {
  
  cloud {
    organization = "mausasia"

    workspaces {
      name = "workspace-dev"
    }
  }
  
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.88.0"
    }

    null = {
      source = "hashicorp/null"
      version = "3.2.2"
    }
  }
}

# Conectando al Remote Management
provider "azurerm" {
  subscription_id = "5f735ab4-4913-44f0-8ff1-ac476e4fe297"
  client_id       = "db557cde-a3d0-4097-8ac7-fec380414c0c"
  client_secret   = local.secret
  tenant_id       = "c324c294-fea7-4d3a-83cd-d260ed39bce2"
  features {}
}