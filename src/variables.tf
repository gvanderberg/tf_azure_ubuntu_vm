# -------------------------------------------

variable "client_id" {
  default = "__client_id__"
}

variable "client_secret" {
  default = "__client_secret__"
}

variable "subscription_id" {
  default = "__subscription_id__"
}

variable "tenant_id" {
  default = "__tenant_id__"
}

# -------------------------------------------

variable "admin_username" {
  default = "__admin_username__"
}

variable "admin_password" {
  default = "__admin_password__"
}

variable "computer_name" {
  default = "__computer_name__"
}

variable "location" {
  default = "__location__"
}

variable "resource_group_name" {
  default = "__resource_group_name__"
}

variable "subnet_name" {
  default = "__subnet_name__"
}

variable "subnet_resource_group_name" {
  default = "__subnet_resource_group_name__"
}

variable "subnet_virtual_network_name" {
  default = "__subnet_virtual_network_name__"
}

variable "tags" {
  default = {
    createdBy   = "__tags_created_by__"
    environment = "__tags_environment__"
    location    = "__tags_location__"
    managedBy   = "__tags_managed_by__"
  }
  type = "map"
}

variable "virtual_machine_name" {
  default = "__virtual_machine_name__"
}

variable "virtual_machine_size" {
  default = "__virtual_machine_size__"
}
