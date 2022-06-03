terraform {
  backend "azurerm" {
    resource_group_name  = "DefaultResourceGroup-SEAU"
    storage_account_name = "tfstoragejune2"
    container_name       = "tfstatejune2"
    key                  = tfstatejune2.tfstate"
  }
}
 
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}
 
data "azurerm_client_config" "current" {}
 
data "azurerm_resource_group" "RGP" {
  name     = "DefaultResourceGroup-SEAU"
}
 
#Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-june-2"
  address_space       = ["192.168.0.0/16"]
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.RGP.name
}
 
# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.RGP.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "192.168.0.0/24"
}