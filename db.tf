#This file manage the db server:

resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = "privatednszone.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_link" {
  name                  = "VnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.main.id
  resource_group_name   = azurerm_resource_group.main.name
}

resource "azurerm_postgresql_flexible_server" "db" {
  name                   = "danielflexserver"
  resource_group_name    = azurerm_resource_group.main.name
  location               = azurerm_resource_group.main.location
  version                = "13"
  delegated_subnet_id    = azurerm_subnet.internal2.id
  private_dns_zone_id    = azurerm_private_dns_zone.private_dns_zone.id
  administrator_login    = "${var.pg_user}"
  administrator_password = "${var.pg_pass}"
  zone                   = "1"

  storage_mb = 32768

  sku_name   = "B_Standard_B1ms"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.private_dns_zone_virtual_network_link]
}

resource "azurerm_postgresql_flexible_server_database" "postgresql_flexible_server_database" {
  name      = "${var.prefix}-db"
  server_id = azurerm_postgresql_flexible_server.db.id
  collation = "en_US.utf8"
  charset   = "utf8"
}

resource "azurerm_postgresql_flexible_server_configuration" "postgresql_flexible_server_configuration" {
  name      = "require_secure_transport"
  server_id = azurerm_postgresql_flexible_server.db.id
  value     = "off"
}