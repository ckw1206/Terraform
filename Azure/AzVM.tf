resource "azurerm_resource_group" "compute" {
  name     = "Terraform-Kyle-Compute"
  location = var.deploy_location
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.compute.name
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = ["Subnet1"]
  vnet_name           = "Main-vNet"

  depends_on = [azurerm_resource_group.compute]
}

# module "AzVM_Win" {
#   for_each                      = toset(var.deploy_env)
#   source                        = "Azure/compute/azurerm"
#   resource_group_name           = azurerm_resource_group.compute.name
#   is_windows_image              = true
#   vm_hostname                   = "Win-${each.value}"
#   admin_password                = "ComplxP@ssw0rd!"
#   vm_os_simple                  = "WindowsServer"
#   vnet_subnet_id                = module.network.vnet_subnets[0]
#   vm_size                       = "Standard_B1s"
#   nb_public_ip                  = "1"
#   vm_os_id                      = "${var.sig_resourceid}${var.sig_image_def[0]}"
#   vm_os_publisher               = "Kyle"
#   vm_os_offer                   = "WindowsServer"
#   vm_os_sku                     = "2019-Standard"
# #  vm_os_version                 = "1.0.0"
#   delete_os_disk_on_termination = true

#   depends_on = [azurerm_resource_group.compute]
# }

# module "AzVM_Linux" {
#   for_each                      = toset(var.deploy_env)
#   source                        = "Azure/compute/azurerm"
#   resource_group_name           = azurerm_resource_group.compute.name
# #  public_ip_dns                = ["linsimplevmips"] // change to a unique name per datacenter region
#   vm_hostname                   = "Linux-${each.value}"
#   vnet_subnet_id                = module.network.vnet_subnets[0]
#   nb_public_ip                  = "1"
#   vm_os_id                      = "${var.sig_resourceid}${var.sig_image_def[1]}"
#   vm_os_publisher               = "Kyle"
#   vm_os_offer                   = "RHEL"
#   vm_os_sku                     = "8.2"
#   delete_os_disk_on_termination = true

#   depends_on = [azurerm_resource_group.compute]
# }