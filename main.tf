#This file run vms module:

module "vms" {
    source = "./modules/vms"
    count  = var.num
    name   = "${var.prefix}-vm-${count.index + 1}"
    resource_group = azurerm_resource_group.main
    admin_username        = "${var.admin_username}"
    admin_password        = "${var.admin_password}"
    host_url = azurerm_public_ip.public_ip.ip_address
    pg_host = "${azurerm_postgresql_flexible_server.db.name}.postgres.database.azure.com"
    okta_org_url = var.okta_org_url
    okta_client_id = var.okta_client_id
    okta_secret = var.okta_secret
    pg_user = var.pg_user
    pg_pass = var.pg_pass
    okta_key = var.okta_key
    subnet_id                     = azurerm_subnet.internal1.id
    depends_on = [azurerm_lb.lb]
}
