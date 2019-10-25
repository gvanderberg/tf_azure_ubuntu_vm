output "virtual_machine_id" {
  value = azurerm_virtual_machine.this.id
}

output "virtual_machine_identity_principal_id" {
  value = azurerm_virtual_machine.this.identity.*.principal_id
}
