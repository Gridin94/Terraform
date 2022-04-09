#Send vm params out of the module:

output "nic_id"{
    value = azurerm_network_interface.main.id
}

output "pass"{
    value = azurerm_linux_virtual_machine.main.admin_password
}