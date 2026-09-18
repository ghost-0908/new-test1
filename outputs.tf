output "resource_group_name" {
  description = "Name of the created resource group."
  value       = azurerm_resource_group.this.name
}

output "vm_name" {
  description = "Name of the created Linux VM."
  value       = azurerm_linux_virtual_machine.this.name
}

output "private_ip_address" {
  description = "Private IP address assigned to the VM network interface."
  value       = azurerm_network_interface.this.private_ip_address
}

output "ssh_public_key" {
  description = "Generated SSH public key installed on the VM."
  value       = tls_private_key.vm_admin.public_key_openssh
}
