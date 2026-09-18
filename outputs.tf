output "resource_group_name" {
  description = "Resource group containing the VM."
  value       = azurerm_resource_group.this.name
}

output "vm_name" {
  description = "Name of the created Linux VM."
  value       = azurerm_linux_virtual_machine.this.name
}

output "public_ip_address" {
  description = "Public IPv4 address of the VM."
  value       = azurerm_public_ip.this.ip_address
}

output "ssh_command" {
  description = "Command to connect to the VM with the matching private key."
  value       = "ssh -i ${trimsuffix(pathexpand(var.ssh_public_key_path), ".pub")} ${var.admin_username}@${azurerm_public_ip.this.ip_address}"
}
