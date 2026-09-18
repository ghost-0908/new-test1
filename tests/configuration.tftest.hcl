mock_provider "azurerm" {}

run "student_vm_plan" {
  command = plan

  variables {
    subscription_id           = "00000000-0000-0000-0000-000000000000"
    ssh_source_address_prefix = "203.0.113.10/32"
    ssh_public_key_path       = "tests/fixtures/test-key.pub"
  }

  assert {
    condition     = azurerm_resource_group.this.name == "artizent"
    error_message = "The default resource group name must be artizent."
  }

  assert {
    condition     = azurerm_linux_virtual_machine.this.name == "nous"
    error_message = "The default VM name must be nous."
  }

  assert {
    condition     = azurerm_linux_virtual_machine.this.disable_password_authentication
    error_message = "Password authentication must remain disabled."
  }
}
