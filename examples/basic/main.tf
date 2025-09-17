# Basic example of the Azure VM module
module "azure_vm" {
  source = "../../"

  resource_group_name = "rg-example-vm-basic"
  location           = "East US"
  vm_name            = "vm-example-basic"
  vm_size            = "Standard_B2s"
  admin_username     = "azureuser"
  admin_password     = "" 

  tags = {
    Environment = "Development"
    Project     = "Example"
    ManagedBy   = "OpenTofu"
  }
}