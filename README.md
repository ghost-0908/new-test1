# Azure VM `sonu`

This Terraform configuration creates the requested private Ubuntu VM:

- Resource group: `vive`
- Virtual network: `arti-vnet`
- Subnet: `arti-subnet`
- Network interface: `arti-nic`
- VM: `sonu`
- Size: `Standard_B2ats_v2`
- Image: Ubuntu 22.04 LTS Gen2
- Login: SSH key only

The VM has a private IP only. The configuration does not create a public IP or
open inbound internet access.

## Validate and deploy from PowerShell

```powershell
az login
az account set --subscription "<your-student-subscription-id>"
$env:ARM_SUBSCRIPTION_ID = az account show --query id --output tsv

Copy-Item terraform.tfvars.example terraform.tfvars
terraform init -upgrade
terraform fmt -check -recursive
terraform validate
terraform test
terraform plan -out sonu.tfplan
terraform apply sonu.tfplan
```

The TLS provider generates the RSA private key and stores it in Terraform
state. Protect the state file and never commit or share it. The included
`.gitignore` excludes local state and plan files.

Remove the lab when it is no longer needed:

```powershell
terraform destroy
```
