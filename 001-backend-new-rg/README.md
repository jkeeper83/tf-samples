# 000-backend-existent-rg
Sample with terraform for creating a backend.conf file (Azure)
---
In this example, I am using an existing azure resource group and I intend to create the following resources:

1. Azure Resource Group
2. Azure Storage Account
3. Azure Storage Container
4. Output formatted file 'backend.conf'

The file backend.conf is intended to be used for remote storage of terraform's tfstates instead of storing them locally.

Files
---
```
.
├── main.tf
├── modules
│   ├── local_file
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── resource_group
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── storage_account
│   │   ├── main.tf
│   │   └── variables.tf
│   └── storage_container
│       ├── main.tf
│       └── variables.tf
├── providers.tf
├── terraform.tfvars
└── variables.tf
```
How to use this example
---

First of all, you are going to need to set up the proper values in the terraform.tfvars files to connect to your azure account, those four values are:
```
provider_client_id       = "..."
provider_client_secret   = "..."
provider_subscription_id = "..."
provider_tenant_id       = "..."
```
After that, you are going to need to fill the values in the remaining variables
```
rgname   = "..."  <- The name of the **new** resource group
location = "..."  <- The current location of the **new** resource group
saname   = "..."  <- Pattern name for the **new** storage account, this will have a random string attached at the end
cname    = "..."  <- Name for the **new** container
```
And after that, you will be able to just run a terraform plan, terraform apply or whatever you want to, after applying the terraform, a new file called backend.conf will be created in the same folder where the root main.tf is located at with the structure as it follows:

```
  backend "azurerm" {
    resource_group_name  = "${var.resource_group_name}"
    storage_account_name = "${var.storage_account_name}"
    container_name       = "${var.container_name}"
    key                  = "${var.key}"
    access_key           = "${var.access_key}"
  }
```

