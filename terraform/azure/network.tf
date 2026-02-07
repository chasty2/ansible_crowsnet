# Virtual Network
resource "azurerm_virtual_network" "crowsnet" {
  name                = "crowsnet"
  address_space       = ["192.168.4.0/22"]
  location            = "eastus"
  resource_group_name = azurerm_resource_group.crowsnet.name
}

# Subnet
resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.crowsnet.name
  virtual_network_name = azurerm_virtual_network.crowsnet.name
  address_prefixes     = ["192.168.4.0/24"]
}
