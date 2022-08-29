resource "azurerm_resource_group" "sigrg" {
  name     = "Terraform-Kyle-ComputeGallery"
  location = var.deploy_location
}

# Creates shared image gallery
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image_gallery
resource "azurerm_shared_image_gallery" "sig" {
  name                = "ImageGallery"
  resource_group_name = azurerm_resource_group.sigrg.name
  location            = azurerm_resource_group.sigrg.location
  description         = "shared images"
}

#Creates image definition
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image
resource "azurerm_shared_image" "WinSrv2019" {
  name                = var.img_WinSrv2019std[0]
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = azurerm_resource_group.sigrg.name
  location            = azurerm_resource_group.sigrg.location
  hyper_v_generation  = "V1"
  os_type             = var.img_WinSrv2019std[1]
  #  specialized         = true

  identifier {
    publisher = var.img_WinSrv2019std[2]
    offer     = var.img_WinSrv2019std[3]
    sku       = var.img_WinSrv2019std[4]
  }
}

resource "azurerm_shared_image" "RHEL82Specialized" {
  name                = "${var.img_RHEL82[0]}specialized"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = azurerm_resource_group.sigrg.name
  location            = azurerm_resource_group.sigrg.location
  hyper_v_generation  = "V1"
  os_type             = var.img_RHEL82[1]
  specialized         = true // didn't run the sysprep

  identifier {
    publisher = var.img_RHEL82[2]
    offer     = var.img_RHEL82[3]
    sku       = "${var.img_RHEL82[4]}specialized"
  }
}

resource "azurerm_shared_image" "RHEL82V2Specialized" {
  name                = "${var.img_RHEL82[0]}V2-specialized"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = azurerm_resource_group.sigrg.name
  location            = azurerm_resource_group.sigrg.location
  hyper_v_generation  = "V2"
  os_type             = var.img_RHEL82[1]
  specialized         = true // didn't run the sysprep

  identifier {
    publisher = var.img_RHEL82[2]
    offer     = var.img_RHEL82[3]
    sku       = "${var.img_RHEL82[4]}V2-specialized"
  }
}