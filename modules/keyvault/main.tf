resource "azurerm_key_vault" "kv" {
  name                        = var.kv_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"

  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "access" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.tenant_id
  object_id = var.object_id

  secret_permissions = ["Get", "List", "Set", "Delete"]
}