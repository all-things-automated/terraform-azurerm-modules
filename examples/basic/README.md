# Basic Example

This example creates a simple Azure VM with default configuration.

## Features

- Ubuntu 22.04 LTS VM
- Password authentication
- Standard B2s VM size
- Default network configuration (10.0.0.0/16)
- Basic NSG rules (SSH, HTTP, HTTPS)
- Public IP address
- Premium SSD storage

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
   ssh azureuser@<public_ip>
   ```
   Use password: `P@ssw0rd123!`

## Clean Up

To destroy the resources:
```bash
terraform destroy
```

## Security Note

This example uses a hardcoded password for demonstration purposes. In production environments:
- Use Azure Key Vault to manage secrets
- Consider SSH key authentication instead
- Implement proper password policies
- Restrict NSG rules to specific source IPs