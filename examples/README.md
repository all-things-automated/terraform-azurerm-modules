# Examples

This directory contains usage examples for the Azure VM OpenTofu module.

## Basic Example

The [basic](./basic/) example demonstrates:
- Simple VM deployment with password authentication
- Default network configuration
- Basic NSG rules (SSH, HTTP, HTTPS)
- Public IP assignment

### Usage

```bash
cd basic/
terraform init
terraform plan
terraform apply
```

## Advanced Example

The [advanced](./advanced/) example demonstrates:
- SSH key authentication (no password)
- Custom network configuration
- Different VM image (CentOS)
- Custom NSG rules
- Premium SSD storage
- Comprehensive tagging

### Usage

```bash
cd advanced/
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars and add your SSH public key
terraform init
terraform plan
terraform apply
```

### SSH Key Setup

To use the advanced example with SSH key authentication:

1. Generate an SSH key pair if you don't have one:
   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```

2. Copy your public key content:
   ```bash
   cat ~/.ssh/id_rsa.pub
   ```

3. Paste the public key content into the `terraform.tfvars` file:
   ```hcl
   ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAA... your-actual-public-key-content"
   ```

## Note on Authentication

Both examples require Azure authentication. You can authenticate using:

- Azure CLI: `az login`
- Service Principal with environment variables
- Managed Identity (when running on Azure)

Refer to the [Terraform AzureRM Provider documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure) for detailed authentication options.