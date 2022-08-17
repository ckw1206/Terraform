locals {
  location            = "eastus"
  env                 = ["dev", "stag"]
  resource_group_name = "Test-Kyle-TF-0817"
}

resource "azurerm_resource_group" "example" {
  name     = local.resource_group_name
  location = local.location
}

module "AzVM_Win" {
  for_each                      = toset(local.env)
  source                        = "Azure/compute/azurerm"
  resource_group_name           = azurerm_resource_group.example.name
  is_windows_image              = true
  vm_hostname                   = "Kyle-${each.value}" // line can be removed if only one VM module per resource group
  admin_password                = "ComplxP@ssw0rd!"
  vm_os_simple                  = "WindowsServer"
  vnet_subnet_id                = module.network.vnet_subnets[0]
  vm_size                       = "Standard_DS1_v2"
  nb_public_ip                  = "0"
  delete_os_disk_on_termination = true

  depends_on = [azurerm_resource_group.example]
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = ["TFsubnet1"]
  vnet_name           = "TF-Kyle-net"

  depends_on = [azurerm_resource_group.example]
}