#This file run vms module:

module "vms" {
    source = "..//modules/vms"
    count  = var.vm_num_prod
    name   = "${var.prefix}-vm-${count.index + 1}"
    resource_group = azurerm_resource_group.main
    admin_username        = "${var.admin_username}"
    admin_password        = "${var.admin_password}"
    subnet_id                     = azurerm_subnet.internal1.id
    depends_on = [azurerm_lb.lb]
}
