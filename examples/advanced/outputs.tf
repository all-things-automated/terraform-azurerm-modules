output "vm_public_ip" {
  description = "Public IP address of the VM"
  value       = module.azure_vm.vm_public_ip
}

output "vm_private_ip" {
  description = "Private IP address of the VM"
  value       = module.azure_vm.vm_private_ip
}

output "ssh_connection_command" {
  description = "SSH command to connect to the VM"
  value       = module.azure_vm.ssh_connection_command
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.azure_vm.resource_group_name
}

output "virtual_network_id" {
  description = "ID of the virtual network"
  value       = module.azure_vm.virtual_network_id
}

output "network_security_group_id" {
  description = "ID of the network security group"
  value       = module.azure_vm.network_security_group_id
}

output "storage_account_name" {
  description = "Name of the storage account for boot diagnostics"
  value       = module.azure_vm.storage_account_name
}