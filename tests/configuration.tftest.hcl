mock_provider "azurerm" {}

run "student_vm_plan" {
  command = plan

  assert {
    condition     = azurerm_resource_group.this.name == "vive"
    error_message = "The resource group name must be vive."
  }

  assert {
    condition     = azurerm_linux_virtual_machine.this.name == "sonu"
    error_message = "The VM name must be sonu."
  }

  assert {
    condition     = azurerm_linux_virtual_machine.this.size == "Standard_B2ats_v2"
    error_message = "The VM size must be Standard_B2ats_v2."
  }

  assert {
    condition     = azurerm_linux_virtual_machine.this.disable_password_authentication
    error_message = "Password authentication must remain disabled."
  }
}
