data "azurerm_subnet" "this" {
  name                 = var.subnet_name
  resource_group_name  = var.subnet_resource_group_name
  virtual_network_name = var.subnet_virtual_network_name
}

resource "random_string" "this" {
  length  = 4
  upper   = false
  lower   = false
  number  = true
  special = false
}

resource "azurerm_network_interface" "this" {
  name                = format("%s%s", var.virtual_machine_name, random_string.this.result)
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  ip_configuration {
    name                          = format("ipconfig%s", random_string.this.result)
    subnet_id                     = data.azurerm_subnet.this.id
    private_ip_address_allocation = "dynamic"
  }

  tags = var.tags
}

resource "azurerm_virtual_machine" "this" {
  name                             = var.virtual_machine_name
  resource_group_name              = var.resource_group_name
  location                         = var.resource_group_location
  network_interface_ids            = [azurerm_network_interface.this.id]
  vm_size                          = var.virtual_machine_size
  delete_os_disk_on_termination    = "true"
  delete_data_disks_on_termination = "true"

  identity {
    type = "SystemAssigned"
  }

  storage_os_disk {
    name              = format("%s_os_disk_1_%s", var.virtual_machine_name, random_string.this.result)
    caching           = "ReadWrite"
    create_option     = "FromImage"
    disk_size_gb      = "128"
    managed_disk_type = "Premium_LRS"
  }

  storage_data_disk {
    name              = format("%s_data_disk_1_%s", var.virtual_machine_name, random_string.this.result)
    caching           = "ReadOnly"
    create_option     = "Empty"
    disk_size_gb      = "256"
    lun               = 0
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04.0-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.os_profile_computer_name
    admin_username = var.os_profile_admin_username
    admin_password = var.os_profile_admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = var.tags
}

# resource "azurerm_virtual_machine_extension" "this" {
#   name                 = "AzureDevOpsAgent"
#   resource_group_name  = var.resource_group_name
#   location             = var.resource_group_location
#   virtual_machine_name = azurerm_virtual_machine.this.name
#   publisher            = "Microsoft.OSTCExtensions"
#   type                 = "CustomScriptForLinux"
#   type_handler_version = "1.2"

#   settings = <<SETTINGS
#   {
#   "commandToExecute": "bash curl -sLSf https://raw.githubusercontent.com/gvanderberg/devops-agents/master/ubuntu/18.04/amd64/prep.sh | sudo sh",
#   "timestamp" : "11"
#   }
# SETTINGS

#   tags = var.tags
# }
