resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location

}

#
# - Create a Virtual Network
#

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = [var.vnet_address_range]

}
