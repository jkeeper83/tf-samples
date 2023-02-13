variable "resource_group_name" {
  type = string
  default  =""
}
variable "storage_account_name" {
  type = string
  default = ""
}
variable "container_name" {
  type = string
  default = ""
}
variable "key" {
  type = string
  default = "terraform.tfstate"
}
variable "access_key" {
  type = string
  default = ""
}