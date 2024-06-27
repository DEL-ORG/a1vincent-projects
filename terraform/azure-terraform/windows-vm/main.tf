resource "azurerm_public_ip" "public-ip" {
  name                = "vm-public-ip"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  tags                = var.tags
}


resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "example-ipconfig"
    subnet_id                     = data.azurerm_subnet.existing_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public-ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.example.id
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_windows_virtual_machine" "example" {
  name                = "example-vm"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  computer_name       = "example-vm"
  admin_username      = "adminuser"
  admin_password      = "AdminPassword1234!"
  size                = "Standard_DS1_v2"

  # delete_os_disk_on_termination = true

  network_interface_ids = [
    azurerm_network_interface.example.id
  ]

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  # os_profile {
  #   computer_name  = "example-vm"
  #   admin_username = "adminuser"
  #   admin_password = "AdminPassword1234!"
  # }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = "127"
    name                 = "windows-vm-disk"
  }
}


# resource "azurerm_resource_group" "example" {
#   name     = "example-resources"
#   location = "West Europe"
# }

# resource "azurerm_virtual_network" "example" {
#   name                = "example-network"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
# }

# resource "azurerm_subnet" "example" {
#   name                 = "internal"
#   resource_group_name  = azurerm_resource_group.example.name
#   virtual_network_name = azurerm_virtual_network.example.name
#   address_prefixes     = ["10.0.2.0/24"]
# }

# resource "azurerm_network_interface" "example" {
#   name                = "example-nic"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.example.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_linux_virtual_machine" "example" {
#   name                = "example-machine"
#   resource_group_name = azurerm_resource_group.example.name
#   location            = azurerm_resource_group.example.location
#   size                = "Standard_F2"
#   admin_username      = "adminuser"
#   network_interface_ids = [
#     azurerm_network_interface.example.id,
#   ]

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
# }