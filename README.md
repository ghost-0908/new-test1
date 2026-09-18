# Azure Linux VM `sonu`

This Terraform configuration creates a private Ubuntu Linux virtual machine and
its required Azure networking:

- Resource group `vive`
- Virtual network `arti-vnet` (`10.0.0.0/16`)
- Subnet `arti-subnet` (`10.0.1.0/24`)
- Network interface `arti-nic` with a dynamic private IP
- Linux VM `sonu` using `Standard_B2ats_v2`
- Ubuntu 22.04 LTS Gen2 and SSH-key-only authentication

No public IP or inbound internet rule is created. Connecting to this VM requires
private network access, such as a VPN, ExpressRoute connection, peered network,
or another host that can route to its virtual network.

## Prerequisites and assumptions

- Terraform `>= 1.6.0, < 2.0.0`
- TFLint for linting
- Azure credentials and subscription context supplied by the execution
  environment; no credentials or subscription IDs are stored in this code
- Permission to create resource groups, networking, and virtual machines
- `Standard_B2ats_v2` capacity and quota in `eastasia`
- A deployment platform that configures and protects the Terraform backend

AzureRM 4.x requires the subscription context at plan/apply time. For a local
Azure CLI session, it can be provided without changing the Terraform files:

```powershell
az login
az account set --subscription "<your-subscription-id>"
$env:ARM_SUBSCRIPTION_ID = az account show --query id --output tsv
```

CI can instead use its supported environment-based identity, managed identity,
workload identity, or service-principal authentication.

## Initialize and verify

These commands do not apply the configuration:

```powershell
terraform init
terraform fmt -recursive
terraform fmt -check -recursive
terraform validate
tflint --init
tflint
```

No `terraform apply` was run automatically. Review a plan and use the deployment
platform's approved workflow when the configuration is ready to deploy.

## Provider lock file for Linux runners

Generate authenticated provider checksums for a Linux AMD64 deployment runner:

```powershell
terraform providers lock -platform=linux_amd64
git add .terraform.lock.hcl
git commit -m "Update Terraform provider lock file"
```

Commit the generated `.terraform.lock.hcl`; do not manually create or edit its
checksums. Terraform obtains signed provider checksums from the registry.

## State security

`tls_private_key.vm_admin` generates the RSA private key. Although the private
key is not exposed as an output, it is stored in Terraform state. The
deployment platform's state storage must use encryption, strict access control,
and locking. Never commit, print, or share a Terraform state file.
