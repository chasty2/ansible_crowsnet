# Create storage account for boot diagnostics
resource "azurerm_storage_account" "diagnostics_storage" {
  name                     = "crowsnetdiags"
  location                 = azurerm_resource_group.crowsnet.location
  resource_group_name      = azurerm_resource_group.crowsnet.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
