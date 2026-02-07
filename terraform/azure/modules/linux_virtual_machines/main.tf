# Create Public IP(s)
resource "azurerm_public_ip" "crowsnet" {
  count               = var.vm_count
  name                = "${var.hostname_list[count.index]}_ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

# Create Network Interface(s)
resource "azurerm_network_interface" "crowsnet" {
  count               = var.vm_count
  name                = "${var.hostname_list[count.index]}_nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  # TODO: Assign fixed private IP's
  ip_configuration {
    name                          = "${var.hostname_list[count.index]}_nic_config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_list[count.index]
    public_ip_address_id          = azurerm_public_ip.crowsnet[count.index].id
  }
}

# Connect network interface(s) with security group
resource "azurerm_network_interface_security_group_association" "crowsnet" {
  count                     = var.vm_count
  network_interface_id      = azurerm_network_interface.crowsnet[count.index].id
  network_security_group_id = var.network_security_group_id
}

# Create virtual machine(s)
resource "azurerm_linux_virtual_machine" "crowsnet" {
  count                 = var.vm_count
  name                  = var.hostname_list[count.index]
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.crowsnet[count.index].id]
  size                  = var.size

  os_disk {
    name                 = "${var.hostname_list[count.index]}_os_disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name  = var.hostname_list[count.index]
  admin_username = var.username

  admin_ssh_key {
    username   = var.username
    public_key = var.public_ssh_key
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account
  }
}