output "public_ips" {
  value = azurerm_linux_virtual_machine.crowsnet[*].public_ip_address
}