# Azure VM OpenTofu Module

This OpenTofu module creates a complete Azure Virtual Machine deployment with all required infrastructure components.

## Features

- **Complete VM Infrastructure**: Creates all necessary Azure resources for a functional VM
- **Flexible Configuration**: Supports both password and SSH key authentication
- **Network Security**: Configurable Network Security Groups with custom rules
- **Storage Options**: Multiple storage account types and caching options
- **Public/Private IP**: Optional public IP address assignment
- **Boot Diagnostics**: Integrated storage account for VM diagnostics
- **Comprehensive Outputs**: Exposes all important resource information

## Resources Created

This module creates the following Azure resources:

- Resource Group
- Virtual Network and Subnet
- Network Security Group with configurable rules
- Public IP Address (optional)
- Network Interface
- Storage Account (for boot diagnostics)
- Linux Virtual Machine

## Usage

### Basic Example

```hcl
module "azure_vm" {
  source = "path/to/this/module"

  resource_group_name = "rg-my-vm"
  location           = "East US"
  vm_name            = "my-vm"
  admin_username     = "azureuser"
  admin_password     = "P@ssw0rd123!"

  tags = {
    Environment = "Development"
    Project     = "MyProject"
  }
}
```

### Advanced Example with SSH Key

```hcl
module "azure_vm" {
  source = "path/to/this/module"

  resource_group_name = "rg-my-vm-advanced"
  location           = "West US 2"
  vm_name            = "my-vm-advanced"
  vm_size            = "Standard_D2s_v3"
  admin_username     = "adminuser"
  
  # Use SSH key authentication
  disable_password_authentication = true
  public_key                     = file("~/.ssh/id_rsa.pub")
  
  # Custom network configuration
  vnet_address_space      = ["172.16.0.0/16"]
  subnet_address_prefixes = ["172.16.1.0/24"]
  
  # Premium storage
  os_disk_storage_account_type = "Premium_LRS"

  tags = {
    Environment = "Production"
    Project     = "WebApp"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| azurerm | ~> 3.0 |
| random | ~> 3.1 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 3.0 |
| random | ~> 3.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Name of the resource group | `string` | n/a | yes |
| vm_name | Name of the virtual machine | `string` | n/a | yes |
| admin_password | Administrator password for the VM | `string` | n/a | yes |
| location | Azure region where resources will be created | `string` | `"East US"` | no |
| vm_size | Size of the virtual machine | `string` | `"Standard_B2s"` | no |
| admin_username | Administrator username for the VM | `string` | `"azureuser"` | no |
| disable_password_authentication | Whether to disable password authentication | `bool` | `false` | no |
| public_key | SSH public key for authentication | `string` | `null` | no |
| os_disk_caching | Caching type for the OS disk | `string` | `"ReadWrite"` | no |
| os_disk_storage_account_type | Storage account type for the OS disk | `string` | `"Premium_LRS"` | no |
| image_publisher | Publisher of the VM image | `string` | `"Canonical"` | no |
| image_offer | Offer of the VM image | `string` | `"0001-com-ubuntu-server-jammy"` | no |
| image_sku | SKU of the VM image | `string` | `"22_04-lts-gen2"` | no |
| image_version | Version of the VM image | `string` | `"latest"` | no |
| vnet_address_space | Address space for the virtual network | `list(string)` | `["10.0.0.0/16"]` | no |
| subnet_address_prefixes | Address prefixes for the subnet | `list(string)` | `["10.0.1.0/24"]` | no |
| enable_public_ip | Whether to create and assign a public IP address | `bool` | `true` | no |
| public_ip_allocation_method | Allocation method for the public IP address | `string` | `"Static"` | no |
| public_ip_sku | SKU for the public IP address | `string` | `"Standard"` | no |
| nsg_rules | List of NSG rules to create | `list(object)` | SSH, HTTP, HTTPS rules | no |
| tags | Tags to assign to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| resource_group_name | Name of the created resource group |
| resource_group_id | ID of the created resource group |
| vm_name | Name of the virtual machine |
| vm_id | ID of the virtual machine |
| vm_private_ip | Private IP address of the virtual machine |
| vm_public_ip | Public IP address of the virtual machine |
| public_ip_fqdn | Fully qualified domain name of the public IP |
| network_interface_id | ID of the network interface |
| virtual_network_id | ID of the virtual network |
| subnet_id | ID of the subnet |
| network_security_group_id | ID of the network security group |
| storage_account_name | Name of the storage account used for boot diagnostics |
| storage_account_id | ID of the storage account used for boot diagnostics |
| admin_username | Administrator username for the VM |
| ssh_connection_command | SSH command to connect to the VM |

## Security Considerations

- **Password Authentication**: When using password authentication, ensure strong passwords and consider using Azure Key Vault
- **SSH Keys**: For production environments, SSH key authentication is recommended over passwords
- **Network Security Groups**: Review and customize NSG rules based on your security requirements
- **Public IP**: Consider whether a public IP is necessary for your use case
- **Storage Account**: Boot diagnostics storage account uses Standard LRS replication

## Examples

See the [examples](./examples/) directory for complete usage examples:

- [Basic Example](./examples/basic/) - Simple VM deployment with password authentication
- [Advanced Example](./examples/advanced/) - Advanced configuration with SSH keys and custom settings

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add or update tests as needed
5. Update documentation
6. Submit a pull request

## License

This module is released under the MIT License. See [LICENSE](LICENSE) for details.