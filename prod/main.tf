#This file run vms module:

module "vms" {
    source          = "..//modules/vms"
    count           = var.num
    name            = "${var.prefix}-vm-${count.index + 1}"
    resource_group  = azurerm_resource_group.main
    admin_username  = "${var.admin_username}"
    admin_password  = "${var.admin_password}"
    subnet_id       = azurerm_subnet.internal1.id
    depends_on      = [azurerm_lb.lb]
}

module "dbs" {
    source          = "..//modules/dbs"
    dbname          = "${var.dbname}prod"
    resource_group  = azurerm_resource_group.main
    vnet            = azurerm_virtual_network.main
    subnet_id       = azurerm_subnet.internal2.id
    pg_user         = var.pg_user
    pg_pass         = var.pg_pass
}