variable "provider_client_id" {
  type    = string
  default = ""
}

variable "provider_client_secret" {
  type    = string
  default = ""
}

variable "provider_subscription_id" {
  type    = string
  default = ""
}

variable "provider_tenant_id" {
  type    = string
  default = ""
}

variable "rgname" {
  type        = string
  description = "Name of resource group"
}

variable "location" {
  type        = string
  description = "Azure location of resource group"
}

variable "saname" {
  type        = string
  description = "Storage account name"
}

variable "cname" {
  type        = string
  description = "Container storage name"
}