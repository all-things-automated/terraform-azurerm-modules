# Advanced example with SSH key authentication and custom network configuration
module "azure_vm" {
  source = "../../"

  resource_group_name = "rg-example-vm-advanced"
  location           = "West US 2"
  vm_name            = "vm-example-advanced"
  vm_size            = "Standard_D2s_v3"
  admin_username     = "adminuser"
  
  # Use SSH key authentication instead of password
  disable_password_authentication = true
  public_key                     = var.ssh_public_key # Provide via variable
  
  # Custom network configuration
  vnet_address_space       = ["172.16.0.0/16"]
  subnet_address_prefixes  = ["172.16.1.0/24"]
  
  # Custom VM image (CentOS)
  image_publisher = "OpenLogic"
  image_offer     = "CentOS"
  image_sku       = "8_5-gen2"
  image_version   = "latest"
  
  # Premium SSD for better performance
  os_disk_storage_account_type = "Premium_LRS"
  os_disk_caching             = "ReadWrite"
  
  # Custom NSG rules
  nsg_rules = [
    {
      name                       = "SSH"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.0.0.0/8" # Restrict SSH to private networks
      destination_address_prefix = "*"
    },
    {
      name                       = "HTTP"
      priority                   = 1002
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "HTTPS"
      priority                   = 1003
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "CustomApp"
      priority                   = 1004
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "8080"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]

  tags = {
    Environment   = "Production"
    Project       = "WebApp"
    ManagedBy     = "OpenTofu"
    CostCenter    = "IT"
    Owner         = "DevOps Team"
    BackupPolicy  = "Daily"
  }
}