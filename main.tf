resource "random_pet" "rg_name" {
  prefix = "ai"
}

resource "azurerm_resource_group" "this" {
  location = var.location
  name     = random_pet.rg_name.id

  tags = {
    application  = "core"
    builtFrom    = "hmcts/slack-help-bot"
    businessArea = "CFT"
    environment  = "production"
  }
}

data "azurerm_client_config" "current" {
}

resource "random_string" "this" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_storage_account" "this" {
  name                            = random_string.this.result
  location                        = azurerm_resource_group.this.location
  resource_group_name             = azurerm_resource_group.this.name
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
}

// KEY VAULT
resource "azurerm_key_vault" "this" {
  name                     = random_string.this.result
  location                 = azurerm_resource_group.this.location
  resource_group_name      = azurerm_resource_group.this.name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = false
}

// Optional application insights
resource "azurerm_application_insights" "this" {
  name                = random_string.this.result
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  application_type    = "web"
}
