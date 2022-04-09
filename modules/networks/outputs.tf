#Send out network params of the module:

output "azurerm_virtual_network"{
    value = azurerm_virtual_network.main
}

output "azurerm_subnet1"{
    value = azurerm_subnet.internal1
}

output "azurerm_subnet2"{
    value = azurerm_subnet.internal2
}