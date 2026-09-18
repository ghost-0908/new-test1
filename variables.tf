variable "subscription_id" {
  description = "Azure Student subscription ID in UUID format."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.subscription_id))
    error_message = "subscription_id must be a valid Azure subscription UUID."
  }
}

variable "location" {
  description = "Azure region in which to create the resources."
  type        = string
  default     = "centralindia"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group."
  type        = string
  default     = "artizent"
}

variable "vm_name" {
  description = "Name and hostname of the Linux VM."
  type        = string
  default     = "nous"

  validation {
    condition     = length(var.vm_name) >= 1 && length(var.vm_name) <= 64 && can(regex("^[A-Za-z0-9][A-Za-z0-9-]*$", var.vm_name)) && !endswith(var.vm_name, "-")
    error_message = "vm_name must be 1-64 characters, contain only letters, numbers, or hyphens, and not end with a hyphen."
  }
}

variable "vm_size" {
  description = "Azure VM size. Standard_B1s is a low-cost choice for a student workload."
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Administrator username for SSH access."
  type        = string
  default     = "azureadmin"

  validation {
    condition     = can(regex("^[A-Za-z_][A-Za-z0-9_-]{0,31}$", var.admin_username))
    error_message = "admin_username must be 1-32 characters and contain only letters, numbers, underscores, or hyphens."
  }
}

variable "ssh_public_key_path" {
  description = "Path to an existing RSA SSH public key."
  type        = string
  default     = "~/.ssh/azure_nous.pub"
}

variable "ssh_source_address_prefix" {
  description = "Public IP CIDR allowed to connect over SSH, for example 203.0.113.10/32."
  type        = string

  validation {
    condition     = can(cidrhost(var.ssh_source_address_prefix, 0))
    error_message = "ssh_source_address_prefix must be a valid IPv4 or IPv6 CIDR block."
  }
}

variable "tags" {
  description = "Tags to apply to the Azure resources."
  type        = map(string)
  default = {
    environment = "student"
    managed-by  = "terraform"
    workload    = "nous"
  }
}
