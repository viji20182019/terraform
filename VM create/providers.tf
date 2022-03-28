terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

provider "azuread" {
  client_id     = "fda1394b-3c13-4c25-8930-716ab979ddc8"
  client_secret = E537Q~X6cmzK1o6xsr8LaL.OjsnmcXBvBg1oq
  tenant_id     = "4a1c1070-2a5b-4bdf-b773-6055c2c740a4"
}
