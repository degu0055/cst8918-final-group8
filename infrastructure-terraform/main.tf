terraform {
  backend "azurerm" {
    resource_group_name   = "cst8918-final-project-group8"
    storage_account_name  = "cst8918g8tfstate"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "8645e34f-3344-494c-acd6-d6785e830b27"
}

# One resource group for all
resource "azurerm_resource_group" "rg" {
  name     = "cst8918-final-project-group8"
  location = "Canada Central"
}

# Storage account for Terraform backend
resource "azurerm_storage_account" "tfstate" {
  name                     = "cst8918g8tfstate"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Blob container to store state file (public read)
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "blob"
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

module "aks_test" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  environment         = "test"
  node_count          = 1
  vm_size             = "Standard_B2s"
  kubernetes_version  = "1.32.0"
}

module "aks_prod" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  environment         = "prod"
  min_count           = 1
  max_count           = 3
  vm_size             = "Standard_B2s"
  kubernetes_version  = "1.32.0"
}
