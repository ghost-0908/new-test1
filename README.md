# Azure VM `nous`

This Terraform configuration creates one Ubuntu Linux VM named `nous` in the
Azure resource group `artizent`, together with the network resources required
to reach it by SSH. The default `Standard_B1s` size is intended to keep a
student-subscription lab inexpensive.

## What it creates

- Resource group `artizent` in `centralindia`
- Virtual network and subnet
- Standard static public IP
- Network security group allowing SSH only from the CIDR you provide
- Network interface
- Ubuntu 24.04 LTS VM `nous` using SSH-key authentication

## Prerequisites

- Terraform 1.10 or newer
- Azure CLI
- An Azure Student subscription with enough remaining credit and quota
- OpenSSH (`ssh` and `ssh-keygen`)

## Deploy from PowerShell

1. Sign in and select the student subscription:

   ```powershell
   az login
   az account list --output table
   az account set --subscription "<your-student-subscription-id>"
   ```

2. Create an SSH key if `~/.ssh/azure_nous` does not already exist:

   ```powershell
   New-Item -ItemType Directory -Force "$HOME/.ssh" | Out-Null
   ssh-keygen -t rsa -b 4096 -f "$HOME/.ssh/azure_nous"
   ```

   Keep the private key private. Terraform reads only
   `~/.ssh/azure_nous.pub`.

3. Create your local variables file:

   ```powershell
   Copy-Item terraform.tfvars.example terraform.tfvars
   az account show --query id --output tsv
   ```

   Edit `terraform.tfvars` and replace the subscription ID and the example
   SSH source address with your own public IP in `/32` form. For example, if
   your public IP is `198.51.100.25`, use `198.51.100.25/32`.

4. Initialize, review, and apply:

   ```powershell
   terraform init
   terraform fmt -check
   terraform validate
   terraform test
   terraform plan -out nous.tfplan
   terraform apply nous.tfplan
   ```

   `terraform test` uses a mocked Azure provider and does not create resources.

5. Connect:

   ```powershell
   terraform output -raw ssh_command
   ```

   Run the command printed by Terraform.

## Keep the student cost low

`Standard_B1s` is intentionally small. Availability and pricing vary by region
and subscription. A stopped VM can still retain billable disks and networking;
when the lab is no longer needed, remove everything with:

```powershell
terraform destroy
```

If `centralindia` has no B1s quota for the subscription, update `location` or
`vm_size` in `terraform.tfvars` to an option available to the subscription.
