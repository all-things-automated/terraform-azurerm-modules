# Advanced Example

This example demonstrates advanced configuration options for the Azure VM module.

## Features

- CentOS 8.5 VM
- SSH key authentication (no password)
- Standard D2s_v3 VM size (2 vCPUs, 8GB RAM)
- Custom network configuration (172.16.0.0/16)
- Custom NSG rules including application port
- Premium SSD storage
- Comprehensive resource tagging
- Restricted SSH access from private networks only

## Prerequisites

- SSH key pair generated
- Azure authentication configured

## Setup

1. Generate SSH key pair (if not already done):
   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```

2. Copy the example variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. Edit `terraform.tfvars` and add your SSH public key:
   ```bash
   cat ~/.ssh/id_rsa.pub
   # Copy the output and paste into terraform.tfvars
   ```

## Usage

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Review the planned changes:
   ```bash
   terraform plan
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```

4. Connect to the VM:
   ```bash
   ssh adminuser@<public_ip>
   ```

## Network Configuration

This example uses a custom network configuration:
- VNet: 172.16.0.0/16
- Subnet: 172.16.1.0/24
- SSH access restricted to private networks (10.0.0.0/8)

## Custom NSG Rules

The example includes these inbound rules:
- SSH (port 22) - restricted to private networks
- HTTP (port 80) - open to internet
- HTTPS (port 443) - open to internet
- Custom application (port 8080) - open to internet

## Clean Up

To destroy the resources:
```bash
terraform destroy
```

## Production Considerations

- Review and adjust NSG rules based on your security requirements
- Consider using Azure Bastion for secure VM access
- Implement proper backup and monitoring
- Use Azure Key Vault for secrets management
- Set up proper logging and alerting