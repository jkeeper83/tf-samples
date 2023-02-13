resource "azurerm_resource_group" "rg" {
    name     = var.rgname
    location = var.location
}

output "rgname" {
    value = azurerm_resource_group.rg.name
    description = "The resource group name"    
}