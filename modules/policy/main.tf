# Policy 1 — Require Environment tag
resource "azurerm_resource_group_policy_assignment" "require_environment_tag" {
  name                 = "require-environment-tag-${var.environment}"
  resource_group_id    = var.resource_group_id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/96670d01-0a4d-4649-9c89-2d3abc0a5025"

  description  = "Requires Environment tag on all resources"
  display_name = "Require Environment Tag - ${var.environment}"

  parameters = jsonencode({
    tagName = {
      value = "Environment"
    }
  })
}

# Policy 2 — Require ManagedBy tag
resource "azurerm_resource_group_policy_assignment" "require_managedby_tag" {
  name                 = "require-managedby-tag-${var.environment}"
  resource_group_id    = var.resource_group_id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/96670d01-0a4d-4649-9c89-2d3abc0a5025"

  description  = "Requires ManagedBy tag on all resources"
  display_name = "Require ManagedBy Tag - ${var.environment}"

  parameters = jsonencode({
    tagName = {
      value = "ManagedBy"
    }
  })
}