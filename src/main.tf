provider "azurerm" {
  version = "=1.34.0"

  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

provider "random" {
  version = "=2.1.2"
}
