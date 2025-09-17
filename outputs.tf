output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "ID of the created resource group"
  value       = azurerm_resource_group.main.id
}

output "vm_name" {
  description = "Name of the virtual machine"
  value       = azurerm_linux_virtual_machine.main.name
}

output "vm_id" {
  description = "ID of the virtual machine"
  value       = azurerm_linux_virtual_machine.main.id
}

output "vm_private_ip" {
  description = "Private IP address of the virtual machine"
  value       = azurerm_network_interface.main.private_ip_address
}

output "vm_public_ip" {
  description = "Public IP address of the virtual machine"
  value       = var.enable_public_ip ? azurerm_public_ip.main[0].ip_address : null
}

output "public_ip_fqdn" {
  description = "Fully qualified domain name of the public IP"
  value       = var.enable_public_ip ? azurerm_public_ip.main[0].fqdn : null
}

output "network_interface_id" {
  description = "ID of the network interface"
  value       = azurerm_network_interface.main.id
}

output "virtual_network_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = azurerm_subnet.main.id
}

output "network_security_group_id" {
  description = "ID of the network security group"
  value       = azurerm_network_security_group.main.id
}

output "storage_account_name" {
  description = "Name of the storage account used for boot diagnostics"
  value       = azurerm_storage_account.main.name
}

output "storage_account_id" {
  description = "ID of the storage account used for boot diagnostics"
  value       = azurerm_storage_account.main.id
}

output "admin_username" {
  description = "Administrator username for the VM"
  value       = var.admin_username
}

output "ssh_connection_command" {
  description = "SSH command to connect to the VM (if public IP is enabled)"
  value       = var.enable_public_ip ? "ssh ${var.admin_username}@${azurerm_public_ip.main[0].ip_address}" : "No public IP configured"
}