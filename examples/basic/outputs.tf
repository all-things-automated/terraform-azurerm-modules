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