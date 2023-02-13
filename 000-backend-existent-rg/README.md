# 000-backend-existent-rg
Sample with terraform for creating a backend.conf file (Azure)
---
In this example, I am using an existing azure resource group and I intend to create the following resources:

1. Azure Storage Account
2. Azure Storage Container
3. Output formatted file 'backend.conf'

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
**NOTE** In this example we are going to use an previously created azure resource group, no news resource groups will be created using this scripts.

First of all, you are going to need to set up the proper values in the terraform.tfvars files to connect to your azure account, those four values are:
```
provider_client_id       = "..."
provider_client_secret   = "..."
provider_subscription_id = "..."
provider_tenant_id       = "..."
```
After that, you are going to need to fill the values in the remaining variables
```
rgname   = "..."  <- The name of the **existent** resource group
location = "..."  <- The current location of the **existent** resource group
saname   = "..."  <- Pattern name for the **new** storage account, this will have a random string attached at the end
cname    = "..."  <- Name for the **new** container
```
Once you have your variables properly set the next step is importing the existing resource group, before doing that, please run **terraform init** for ensuring you have it all ready before giving it a go. Once the init has finished you will need to run the following
```
terraform import module.resource_group.azurerm_resource_group.rg "RESOURCE_GROUP_SUBSCRIPTION_ID"
```
If you don't know what is the subscription id just log into the shell with az login or use the cloudshell and go through the command **az group list** to find this information.
As soon as the resource group is imported you will get a message pretty much similar to this one
```
module.resource_group.azurerm_resource_group.rg: Importing from ID "XXXXXXXXXXXXXXXXXXXXXXXXX"...
data.azurerm_client_config.current: Reading...
module.resource_group.azurerm_resource_group.rg: Import prepared!
  Prepared azurerm_resource_group for import
module.resource_group.azurerm_resource_group.rg: Refreshing state... [id=/subscriptions/XXXXXXXXXXXXXXX/resourceGroups/XXXXXXX]
data.azurerm_client_config.current: Read complete after 0s [id=....]

Import successful!
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

Keep in mind, that if you are going to run a terraform destroy you could destroy the resource group you have imported before applying, so, if you want to keep the given resource group, just remove it from the imported resources by running

```
terraform state rm module.resource_group.azurerm_resource_group.rg
```

