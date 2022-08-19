resource "azurerm_resource_group" "sigrg" {
  name     = "Terraform-Kyle-ComputeGallery"
  location = var.deploy_location
}

# Creates Shared Image Gallery
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image_gallery
resource "azurerm_shared_image_gallery" "sig" {
  name                = "ImageGallery"
  resource_group_name = azurerm_resource_group.sigrg.name
  location            = azurerm_resource_group.sigrg.location
  description         = "Shared images"
}

#Creates image definition
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image
resource "azurerm_shared_image" "WinSrv2019" {
  name                = "${var.img_WinSrv2019std[0]}"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = azurerm_resource_group.sigrg.name
  location            = azurerm_resource_group.sigrg.location
  hyper_v_generation  = "V2"
  os_type             = "${var.img_WinSrv2019std[1]}"

  identifier {
    publisher = "${var.img_WinSrv2019std[2]}"
    offer     = "${var.img_WinSrv2019std[3]}"
    sku       = "${var.img_WinSrv2019std[4]}"
  }
}

resource "azurerm_shared_image" "RHEL82" {
  name                = "${var.img_RHEL82[0]}"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = azurerm_resource_group.sigrg.name
  location            = azurerm_resource_group.sigrg.location
  hyper_v_generation  = "V2"
  os_type             = "${var.img_RHEL82[1]}"

  identifier {
    publisher = "${var.img_RHEL82[2]}"
    offer     = "${var.img_RHEL82[3]}"
    sku       = "${var.img_RHEL82[4]}"
  }
}