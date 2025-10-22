terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=4.1.0"
        }
    }
}

provider "azurerm" {
  # make this step comment/remove before running the code, because it won't try to connect Azure
  resource_provider_registrations = "none" 
  features {}
    # add your authentication details to deploy in Azure
    #subscription_id = "XXXX-XXXX-XXXX-XXXX"
    #client_id = "XXXX-XXXX-XXXX-XXXX"
    #client_secret = "XXXX-XXXX-XXXX-XXXX"
    #tenant_id = "XXXX-XXXX-XXXX-XXXX"
}

resource "azurerm_resource_group" "rg1" {
    name = "${var.rgname}"
    location = "${var.rglocation}"
    tags = {
        Environment =  "Demo"
    }
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "${var.prefix}-vnet"
  address_space       = ["${var.vnet_cidr_prefix}"]
  resource_group_name = azurerm_resource_group.rg1.name
  #we can also mention ${var.rgname}, but every time it will check in var file.
  location            = azurerm_resource_group.rg1.location
}

resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["${var.subnet1_cidr_prefix}"]
}

resource "azurerm_network_security_group" "nsg1" {
  name                = "${var.prefix}-nsg"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
}

resource "azurerm_network_security_rule" "rdp" {
    name = "rdp"
    resource_group_name = azurerm_resource_group.rg1.name
    network_security_group_name = azurerm_network_security_group.nsg1.name
    priority = 102
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "3389"
    source_address_prefix = "*"
    destination_address_prefix = "*"
}

resource "azurerm_subnet_network_security_group_association" "nsg_subnet_association" {
    subnet_id = azurerm_subnet.subnet1.id
    network_security_group_id = azurerm_network_security_group.nsg1.id
}

resource "azurerm_network_interface" "nic1" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "main" {
  name                = "${var.prefix}-vm1"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "admin#123" #you can provide your own password
  network_interface_ids = [
    azurerm_network_interface.nic1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}