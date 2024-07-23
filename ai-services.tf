resource "azapi_resource" "AIServices" {
  type      = "Microsoft.CognitiveServices/accounts@2023-10-01-preview"
  name      = "my-ai-services"
  location  = azurerm_resource_group.this.location
  parent_id = azurerm_resource_group.this.id

  identity {
    type = "SystemAssigned"
  }

  body = jsonencode({
    name = "my-ai-services"

    properties = {
      apiProperties = {
        statisticsEnabled = false
      }
      customSubDomainName = random_string.this.result
    }
    kind = "AIServices"
    sku = {
      // https://learn.microsoft.com/en-us/azure/analysis-services/analysis-services-overview#europe
      name = "S0"
    }
  })

  response_export_values = ["*"]
}

resource "azapi_resource" "AIServicesConnection" {
  type      = "Microsoft.MachineLearningServices/workspaces/connections@2024-04-01-preview"
  name      = "my-ai-services"
  parent_id = azapi_resource.hub.id

  body = jsonencode({
    properties = {
      category      = "AIServices",
      target        = jsondecode(azapi_resource.AIServices.output).properties.endpoint,
      authType      = "AAD",
      isSharedToAll = true,
      metadata = {
        ApiType    = "Azure",
        ResourceId = azapi_resource.AIServices.id
      }
    }
  })
  response_export_values = ["*"]
}
