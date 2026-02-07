module "internal" {
  vm_count                  = 2
  source                    = "./modules/linux_virtual_machines"
  hostname_list             = var.internal_vm_names
  private_ip_list           = var.internal_private_ips
  location                  = azurerm_resource_group.crowsnet.location
  resource_group_name       = azurerm_resource_group.crowsnet.name
  subnet_id                 = azurerm_subnet.internal.id
  network_security_group_id = azurerm_network_security_group.internal.id
  public_ssh_key            = var.public_ssh_key
  storage_account           = azurerm_storage_account.diagnostics_storage.primary_blob_endpoint
}

module "public" {
  vm_count                  = 1
  source                    = "./modules/linux_virtual_machines"
  hostname_list             = var.public_vm_names
  private_ip_list           = var.public_private_ips
  location                  = azurerm_resource_group.crowsnet.location
  resource_group_name       = azurerm_resource_group.crowsnet.name
  subnet_id                 = azurerm_subnet.internal.id
  network_security_group_id = azurerm_network_security_group.public.id
  public_ssh_key            = var.public_ssh_key
  storage_account           = azurerm_storage_account.diagnostics_storage.primary_blob_endpoint
}
