#This file manage the db server:

resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = "privatednszone.postgres.database.azure.com"
  resource_group_name = var.resource_group.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_link" {
  name                  = "VnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = var.vnet.id
  resource_group_name   = var.resource_group.name
}

resource "azurerm_postgresql_flexible_server" "db" {
  name                   = var.dbname
  resource_group_name    = var.resource_group.name
  location               = var.resource_group.location
  version                = "13"
  delegated_subnet_id    = var.subnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.private_dns_zone.id
  administrator_login    = "${var.pg_user}"
  administrator_password = "${var.pg_pass}"
  zone                   = "1"

  storage_mb = 32768

  sku_name   = "B_Standard_B1ms"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.private_dns_zone_virtual_network_link]
}

resource "azurerm_postgresql_flexible_server_database" "postgresql_flexible_server_database" {
  name      = "${var.dbname}-db"
  server_id = azurerm_postgresql_flexible_server.db.id
  collation = "en_US.utf8"
  charset   = "utf8"
}

resource "azurerm_postgresql_flexible_server_configuration" "postgresql_flexible_server_configuration" {
  name      = "require_secure_transport"
  server_id = azurerm_postgresql_flexible_server.db.id
  value     = "off"
}