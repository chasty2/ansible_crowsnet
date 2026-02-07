# Network Security Group/Rules
resource "azurerm_network_security_group" "internal" {
  name                = "internal"
  location            = azurerm_resource_group.crowsnet.location
  resource_group_name = azurerm_resource_group.crowsnet.name

  # Allow SSH from machine running Ansible to configure VM's
  security_rule {
    name                       = "SSH-Builder"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.builder_public_ip
    destination_address_prefix = "*"
  }

  # Allow SSH internally
  security_rule {
    name                       = "SSH-Internal"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "192.168.4.0/24"
    destination_address_prefix = "192.168.4.0/24"
  }

  # Allow proxy to connect to jellyfin app on bailey
  security_rule {
    name                       = "Jellyfin"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8096"
    source_address_prefix      = "192.168.4.101"
    destination_address_prefix = "192.168.4.125"
  }

  # Allow proxy to connect to foundry app on bailey
  security_rule {
    name                       = "Foundry"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "30000"
    source_address_prefix      = "192.168.4.101"
    destination_address_prefix = "192.168.4.125"
  }
}

resource "azurerm_network_security_group" "public" {
  name                = "public"
  location            = azurerm_resource_group.crowsnet.location
  resource_group_name = azurerm_resource_group.crowsnet.name

  # Allow SSH from machine running Ansible to configure VM's
  security_rule {
    name                       = "SSH-Builder"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.builder_public_ip
    destination_address_prefix = "*"
  }

  # Allow SSH from any machine to gate
  security_rule {
    name                       = "SSH-Public"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "192.168.4.100"
  }

  # Allow SSH internally
  security_rule {
    name                       = "SSH-Internal"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "192.168.4.0/24"
    destination_address_prefix = "192.168.4.0/24"
  }

  # Allow HTTPS from any machine to proxy
  security_rule {
    name                       = "HTTPS"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "192.168.4.100"
  }

  # Allow HTTP from any machine to proxy
  security_rule {
    name                       = "HTTP"
    priority                   = 1005
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "192.168.4.100"
  }

  # Allow NGINX Proxy Manager admin UI from Builder
  security_rule {
    name                       = "Proxy-UI"
    priority                   = 1006
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "81"
    source_address_prefix      = var.builder_public_ip
    destination_address_prefix = "192.168.4.100"
  }
}