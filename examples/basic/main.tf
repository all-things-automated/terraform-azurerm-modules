# Basic example of the Azure VM module
module "azure_vm" {
  source = "../../"

  resource_group_name = "rg-example-vm-basic"
  location           = "East US"
  vm_name            = "vm-example-basic"
  vm_size            = "Standard_B2s"
  admin_username     = "azureuser"
  admin_password     = "P@ssw0rd123!" # In production, use Azure Key Vault or other secure methods

  tags = {
    Environment = "Development"
    Project     = "Example"
    ManagedBy   = "OpenTofu"
  }
}