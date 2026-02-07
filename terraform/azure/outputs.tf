output "resource_group_id" {
  value = azurerm_resource_group.crowsnet.id
}

output "internal_group_public_ips" {
  value = module.internal.public_ips
}

output "public_group_public_ips" {
  value = module.public.public_ips
}