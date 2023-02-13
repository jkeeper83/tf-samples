resource "local_file" "file_output" {
  content = <<-EOT
  backend "azurerm" {
    resource_group_name  = "${var.resource_group_name}"
    storage_account_name = "${var.storage_account_name}"
    container_name       = "${var.container_name}"
    key                  = "${var.key}"
    access_key           = "${var.access_key}"
  }
  EOT
  filename = "./backend.conf"
}