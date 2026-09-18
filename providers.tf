provider "azurerm" {
  features {}

  subscription_id = var.subscription_id

  # AzureRM 5.x no longer registers resource providers automatically.
  resource_providers_to_register = [
    "Microsoft.Compute",
    "Microsoft.Network",
  ]
}
