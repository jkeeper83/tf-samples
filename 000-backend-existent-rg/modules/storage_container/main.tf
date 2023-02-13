resource "azurerm_storage_container" "tfstate" {
  name                  = var.cname
  storage_account_name  = var.saname
  container_access_type = "blob"
}

output "storage_container_name" {
  value = azurerm_storage_container.tfstate.name
}

output "storage_container_id" {
  value = azurerm_storage_container.tfstate.resource_manager_id
}