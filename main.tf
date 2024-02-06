resource "azurerm_virtual_network" "ttnetwork" {
  name                = "tt${terraform.workspace}-vnet"
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = [local.virtual_network.address_space]
}

resource "azurerm_subnet" "ttsubnet" {
  name                 = "tt${terraform.workspace}-subnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.ttnetwork.name
  address_prefixes     = [cidrsubnet(local.virtual_network.address_space, 1, 0)]
  depends_on = [ azurerm_virtual_network.ttnetwork ]
}

resource "azurerm_subnet" "ttsubnet2" {
  name                 = "tt${terraform.workspace}-subnet2"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.ttnetwork.name
  address_prefixes     = [cidrsubnet(local.virtual_network.address_space, 2, 0)]
  depends_on = [ azurerm_virtual_network.ttnetwork ]
}

resource "azurerm_network_security_group" "ttnsg" {
  name                = "tt${terraform.workspace}-ttnsg"
  location            = local.location
  resource_group_name = local.resource_group_name

  security_rule {
    name                       = "RDP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  depends_on = [ azurerm_virtual_network.ttnetwork ]
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  network_security_group_id = azurerm_network_security_group.ttnsg.id
  subnet_id                 = azurerm_subnet.ttsubnet.id
  depends_on = [ azurerm_network_security_group.ttnsg, azurerm_virtual_network.ttnetwork ]
}
  
