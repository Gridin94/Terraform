#This file run all modules:

module "vms" {
    source          = "..//modules/vms"
    count           = var.num
    name            = "${var.prefix}-vm-${count.index + 1}"
    resource_group  = azurerm_resource_group.main
    admin_username  = "${var.admin_username}"
    admin_password  = "${var.admin_password}"
    subnet_id       = module.networks.azurerm_subnet1.id
    depends_on      = [azurerm_lb.lb]
}

module "dbs" {
    source          = "..//modules/dbs"
    dbname          = "${var.dbname}prod"
    resource_group  = azurerm_resource_group.main
    vnet            = module.networks.azurerm_virtual_network
    subnet_id       = module.networks.azurerm_subnet2.id
    pg_user         = var.pg_user
    pg_pass         = var.pg_pass
}

module "networks" {
    source          = "..//modules/networks"
    vnetname        = var.prefix
    resource_group  = azurerm_resource_group.main
}