data "azurerm_client_config" "current" {}

module "resource_group" {
  source   = "./modules/resource_group"
  rgname   = var.rgname
  location = var.location
}

module "storage_account" {
  source              = "./modules/storage_account"
  resource_group_name = module.resource_group.rgname
  saname              = var.saname
  location            = var.location
  depends_on = [module.resource_group.id]
}

module "storage_container" {
  source     = "./modules/storage_container"
  cname      = var.cname
  saname     = module.storage_account.whole_storage_account_name
  depends_on = [module.storage_account.primary_key]
  
}

module "local_file" {
  source = "./modules/local_file"
  resource_group_name  = var.rgname
  storage_account_name = module.storage_account.whole_storage_account_name
  container_name       = module.storage_container.storage_container_name
  key                  = "terraform.tfstate"
  access_key           = nonsensitive(module.storage_account.primary_key)

  depends_on = [module.storage_container.storage_container_id]
}
output "rgname" {
  value = var.rgname
}
output "storage_account_name" {
  value = module.storage_account.whole_storage_account_name
}
output "storage_container_name" {
  value = module.storage_container.storage_container_name
}
output "primary_key" {
  value     = module.storage_account.primary_key
  sensitive = true
}
output "primary_key_not_hidden" {
  value = nonsensitive(module.storage_account.primary_key)
}
output "storage_container_id" {
  value = module.storage_container.storage_container_id
}

# terraform import module.resource_group.azurerm_resource_group.rg "/subscriptions/56f6cee6-94a9-4e48-a18a-8fc8f3905efd/resourceGroups/asitur-TEST"
# terraform state rm module.resource_group.azurerm_resource_group.rg