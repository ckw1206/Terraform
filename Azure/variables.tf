variable "deploy_location" {
  type    = string
  default = "eastus"
}

variable "deploy_env" {
  type    = list(string)
  default = ["dev"]
}

variable "sig_resourceid" {
  type    = string
  default = "/subscriptions/15460747-219f-4ef3-8606-651f1fa0d4bc/resourceGroups/Test-Kyle/providers/Microsoft.Compute/galleries/ComputeGallery/images/"
}

variable "sig_image_def" {
  type    = list(string)
  default = ["WinServer2019std", "RHEL-8.2"]
}

variable "img_WinSrv2019std" {
  type        = list(string)
  default     = ["WinSrv2019std", "Windows", "Kyle", "WindowsServer", "2019-Standard"]
  description = "name, os-type, publisher, offer, sku"
}

variable "img_RHEL82" {
  type        = list(string)
  default     = ["RHEL8.2", "Linux", "Kyle", "RHEL", "8.2"]
  description = "name, os-type, publisher, offer, sku"
}

# variable "vm_os_simple" {
#   default = ""
# }

# # Definition of the sig_img_os = "publisher,offer,sku"
# variable "sig_img_os" {
#   default = {
#     "WinSrv2019std" = "Kyle,WindowsServer,2019-Standard"
#     "RHEL8.2"       = "Kyle,RHEL,8.2"
#   }
# }
