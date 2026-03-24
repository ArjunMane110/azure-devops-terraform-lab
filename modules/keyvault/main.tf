resource "azurerm_key_vault" "this" {
  name                       = var.keyvault_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = var.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  rbac_authorization_enabled = false

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    secret_permissions = [
      "Backup", "Delete", "Get", "List",
      "Purge", "Recover", "Restore", "Set"
    ]

    key_permissions = [
      "Get", "List"
    ]

    certificate_permissions = [
      "Get", "List"
    ]
  }

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.pipeline_object_id

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Purge"
    ]
  }

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "devops-lab"
  }
}

resource "azurerm_key_vault_secret" "vm_password" {
  name         = "vm-admin-password"
  value        = var.vm_admin_password
  key_vault_id = azurerm_key_vault.this.id

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
