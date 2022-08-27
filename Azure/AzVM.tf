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

module "AzVM" {
  for_each            = toset(var.deploy_env)
  source              = "git::https://github.com/ckw1206/my-terraform-azurerm-compute.git"
  resource_group_name = azurerm_resource_group.compute.name
  is_windows_image    = true
  vm_hostname         = "Win-${each.value}"
  vm_os_simple        = "WindowsServer"
  vnet_subnet_id      = module.network.vnet_subnets[0]
  vm_size             = "Standard_B1s"
  nb_public_ip        = "0"
  vm_os_id            = "${var.sig_resourceid}${var.img_WinSrv2019std[0]}"
  vm_os_publisher     = "${var.img_WinSrv2019std[2]}"
  vm_os_offer         = "${var.img_WinSrv2019std[3]}"
  vm_os_sku           = "${var.img_WinSrv2019std[4]}"
  admin_password      = "ComplexP@ssw0rd"
  #  vm_os_version                 = "1.0.0"
  delete_os_disk_on_termination = true

  depends_on = [azurerm_resource_group.compute]
}

# module "AzVM_Linux" {
#   for_each                      = toset(var.deploy_env)
#   source                        = "git::https://github.com/ckw1206/my-terraform-azurerm-compute.git"
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