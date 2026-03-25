terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.63.0"
    }
  }
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "devops-lab"
  }
}

module "vnet" {
  source = "../../modules/vnet"

  vnet_name           = var.vnet_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = var.vnet_address_space
  subnet_name         = var.subnet_name
  subnet_prefix       = var.subnet_prefix
  environment         = var.environment
}

module "vm" {
  source = "../../modules/vm"

  vm_name             = var.vm_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  subnet_id           = module.vnet.subnet_id
  environment         = var.environment
  create_public_ip    = var.create_public_ip
}

module "storage" {
  source = "../../modules/storage"

  storage_account_name = var.storage_account_name
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  environment          = var.environment
}

module "nsg" {
  source = "../../modules/nsg"

  nsg_name            = var.nsg_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = module.vnet.subnet_id
  environment         = var.environment

  security_rules = [
    {
      name                       = "Allow-RDP"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "Allow-HTTP"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

data "azurerm_client_config" "current" {}
module "keyvault" {
  source = "../../modules/keyvault"

  keyvault_name       = var.keyvault_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  environment         = var.environment
  tenant_id           = var.tenant_id
  object_id           = var.object_id
  pipeline_object_id  = var.pipeline_object_id
  vm_admin_password   = var.admin_password
}

module "log_analytics" {
  source = "../../modules/log_analytics"

  name                = "law-ajm-dev-001"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "devops-lab"
  }
}

module "policy" {
  source = "../../modules/policy"

  resource_group_id = azurerm_resource_group.main.id
  environment       = var.environment
}

module "loadbalancer" {
  source = "../../modules/loadbalancer"

  lb_name             = var.lb_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = module.vnet.subnet_id
  environment         = var.environment
}