data "azurerm_client_config" "current" {

}


resource "azurerm_key_vault" "ttkeyvaultIC" {
  name                        = "ttkeyvaultIC"
  location                    = local.location
  resource_group_name         = local.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name = "standard"
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get"
    ]

  }
}

data "azurerm_key_vault_secret" "ttclave01" {
  name         = "ttclave01"
  key_vault_id = azurerm_key_vault.ttkeyvaultIC.id
  depends_on = [ azurerm_key_vault.ttkeyvaultIC ]  
  
}

