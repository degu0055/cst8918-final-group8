resource "azurerm_resource_group" "rg" {
  name     = "cst8918-final-project-group8" # change group number if needed
  location = "canadacentral"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "cst8918finalgroup8tfstate" # must be globally unique and lowercase
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = false
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}
