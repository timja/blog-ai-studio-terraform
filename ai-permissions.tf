resource "azurerm_role_assignment" "identity_access_to_ai_services" {
  principal_id = data.azurerm_client_config.current.object_id
  scope        = azapi_resource.AIServices.id

  role_definition_name = "Cognitive Services OpenAI User"
}
