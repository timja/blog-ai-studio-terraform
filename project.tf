resource "azapi_resource" "project" {
  type      = "Microsoft.MachineLearningServices/workspaces@2024-04-01-preview"
  name      = "my-project"
  location  = azurerm_resource_group.this.location
  parent_id = azurerm_resource_group.this.id

  identity {
    type = "SystemAssigned"
  }

  body = jsonencode({
    properties = {
      description   = "Description"
      friendlyName  = "Display name"
      hubResourceId = azapi_resource.hub.id
    }
    kind = "Project"
  })
}
