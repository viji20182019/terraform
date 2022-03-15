variable "vnet_address_range" {
  description = "IP Range of the virtual network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "location" {
  description = "Location of the resource group"
  type        = string
  default     = "East US"
}
