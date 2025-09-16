# Generate random ID for unique resource naming
resource "random_id" "main" {
  byte_length = 8
}

# Validation: Ensure either password or SSH key is provided
locals {
  validate_auth = var.disable_password_authentication ? (
    var.public_key != null ? true : 
    tobool("SSH key must be provided when password authentication is disabled")
  ) : (
    var.admin_password != null ? true :
    tobool("Admin password must be provided when password authentication is enabled")
  )
}

# Create Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Create Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "${var.vm_name}-vnet-${random_id.main.hex}"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

# Create Subnet
resource "azurerm_subnet" "main" {
  name                 = "${var.vm_name}-subnet-${random_id.main.hex}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.subnet_address_prefixes
}

# Create Network Security Group
resource "azurerm_network_security_group" "main" {
  name                = "${var.vm_name}-nsg-${random_id.main.hex}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

# Create NSG Rules
resource "azurerm_network_security_rule" "main" {
  count                       = length(var.nsg_rules)
  name                        = var.nsg_rules[count.index].name
  priority                    = var.nsg_rules[count.index].priority
  direction                   = var.nsg_rules[count.index].direction
  access                      = var.nsg_rules[count.index].access
  protocol                    = var.nsg_rules[count.index].protocol
  source_port_range           = var.nsg_rules[count.index].source_port_range
  destination_port_range      = var.nsg_rules[count.index].destination_port_range
  source_address_prefix       = var.nsg_rules[count.index].source_address_prefix
  destination_address_prefix  = var.nsg_rules[count.index].destination_address_prefix
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name
}

# Associate NSG to Subnet
resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = azurerm_subnet.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

# Create Public IP (conditional)
resource "azurerm_public_ip" "main" {
  count               = var.enable_public_ip ? 1 : 0
  name                = "${var.vm_name}-pip-${random_id.main.hex}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  tags                = var.tags
}

# Create Network Interface
resource "azurerm_network_interface" "main" {
  name                = "${var.vm_name}-nic-${random_id.main.hex}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.enable_public_ip ? azurerm_public_ip.main[0].id : null
  }
}

# Associate NSG to Network Interface
resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

# Create Storage Account for Boot Diagnostics
resource "azurerm_storage_account" "main" {
  name                     = "bootdiag${random_id.main.hex}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

# Create Virtual Machine
resource "azurerm_linux_virtual_machine" "main" {
  name                = var.vm_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  size                = var.vm_size
  admin_username      = var.admin_username
  tags                = var.tags

  # Disable password authentication if public key is provided
  disable_password_authentication = var.disable_password_authentication

  # Set admin password if password authentication is enabled
  admin_password = var.disable_password_authentication ? null : var.admin_password

  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  # SSH Key configuration (only if public key is provided)
  dynamic "admin_ssh_key" {
    for_each = var.public_key != null ? [1] : []
    content {
      username   = var.admin_username
      public_key = var.public_key
    }
  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.main.primary_blob_endpoint
  }
}