# - Public IP (To Login to Linux VM)
#

resource "azurerm_public_ip" "pip" {
  name                = "${var.prefix}-linuxvm-public-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = var.allocation_method[0]

}

#
# - Create a Network Interface Card for Virtual Machine
#

resource "azurerm_network_interface" "nic" {
  name                = "${var.prefix}-linuxvm-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "${var.prefix}-nic-ipconfig"
    subnet_id                     = azurerm_subnet.web.id
    public_ip_address_id          = azurerm_public_ip.pip.id
    private_ip_address_allocation = var.allocation_method[1]
  }
}


#
# - Create a Linux Virtual Machine
# 

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "${var.prefix}-linuxvm"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  network_interface_ids           = [azurerm_network_interface.nic.id]
  size                            = var.virtual_machine_size
  computer_name                   = var.computer_name
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = "false"

  os_disk {
    name                 = "${var.prefix}-linuxvm-os-disk"
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.vm_image_version

  }



}


resource "azurerm_virtual_machine_extension" "testing" {
  name                       = "Linuxvm"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm.id
  publisher                  = "Microsoft.Azure.Extensions"
  type                       = "CustomScript"
  type_handler_version       = "2.0"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
        "script": "${filebase64("./modules/httpd.sh")}"
    }
SETTINGS
}