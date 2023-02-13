resource "random_string" "random" {
  length = 6
  special = false
  upper = false
}

resource "azurerm_storage_account" "sa" {
  name                     = "${var.saname}${random_string.random.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  tags = {
    environment = "test"
  }
}

output "primary_key" {
  value = azurerm_storage_account.sa.primary_access_key
}
output "whole_storage_account_name" {
  value = "${var.saname}${random_string.random.result}"
}