resource "azurerm_resource_group" "example1" {
  name     = "example-resource-group"
  location = "West Europe"
}

resource "azurerm_virtual_network" "example2" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.example1.location}"
  resource_group_name = "${azurerm_resource_group.example1.name}"
  
  dynamic "subnet" {
    for_each = {
      subnet1 = "10.0.1.0/24"
      subnet2 = "10.0.2.0/24"
    }
    content {
      name           = subnet.key
      address_prefix = subnet.value
    }
  }
}
