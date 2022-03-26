#Send out vm network interface out of the module:

output "nic_id"{
    value = azurerm_network_interface.main.id
}