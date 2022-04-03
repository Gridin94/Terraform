#This file create a vm server with a custom data script:

resource "azurerm_linux_virtual_machine" "main" {
  name                  = var.name
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  network_interface_ids = [azurerm_network_interface.main.id]
  size                  = "Standard_D2as_v5"
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  disable_password_authentication = false

    source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    caching       = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

resource "azurerm_network_interface" "main" {
  name                = "${var.name}-nic"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

