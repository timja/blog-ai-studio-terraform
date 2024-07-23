resource "azapi_resource" "hub" {
  type      = "Microsoft.MachineLearningServices/workspaces@2024-04-01-preview"
  name      = "hub"
  location  = azurerm_resource_group.this.location
  parent_id = azurerm_resource_group.this.id

  identity {
    type = "SystemAssigned"
  }

  body = jsonencode({
    properties = {
      description    = "Your description"
      friendlyName   = "Display name for Hub"
      storageAccount = azurerm_storage_account.this.id
      keyVault       = azurerm_key_vault.this.id

      applicationInsights = azurerm_application_insights.this.id
    }
    kind = "Hub"
  })
}
