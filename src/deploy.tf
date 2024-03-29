module "rg" {
  source = "./modules/rg"

  resource_group_name     = var.resource_group_name
  resource_group_location = var.location
  tags                    = var.tags
}

module "vm" {
  source = "./modules/vm"

  os_profile_admin_username   = var.admin_username
  os_profile_admin_password   = var.admin_password
  os_profile_computer_name    = var.computer_name
  resource_group_name         = module.rg.resource_group_name
  resource_group_location     = module.rg.resource_group_location
  subnet_name                 = var.subnet_name
  subnet_resource_group_name  = var.subnet_resource_group_name
  subnet_virtual_network_name = var.subnet_virtual_network_name
  virtual_machine_name        = var.virtual_machine_name
  virtual_machine_size        = var.virtual_machine_size
  tags                        = var.tags
}
