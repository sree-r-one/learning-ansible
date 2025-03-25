provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# 🔁 ACR: Use existing or create if needed
data "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_container_registry" "acr" {
  count               = var.create_acr ? 1 : 0
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

# 🔁 App Service Plan: Use existing or create if needed
data "azurerm_service_plan" "plan" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_service_plan" "plan" {
  count               = var.create_plan ? 1 : 0
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name

  os_type  = "Linux"
  sku_name = "B1"
}

# 🔁 App Services: Use existing or create if needed
data "azurerm_app_service" "frontend" {
  name                = "vite-container-frontend"
  resource_group_name = var.resource_group_name
}

data "azurerm_app_service" "backend" {
  name                = "express-container-backend"
  resource_group_name = var.resource_group_name
}

# 💡 Smart selectors
locals {
  acr_login_server   = var.create_acr  ? azurerm_container_registry.acr[0].login_server       : data.azurerm_container_registry.acr.login_server
  acr_admin_username = var.create_acr  ? azurerm_container_registry.acr[0].admin_username     : data.azurerm_container_registry.acr.admin_username
  acr_admin_password = var.create_acr  ? azurerm_container_registry.acr[0].admin_password     : data.azurerm_container_registry.acr.admin_password
  service_plan_id    = var.create_plan ? azurerm_service_plan.plan[0].id                      : data.azurerm_service_plan.plan.id
  frontend_hostname  = var.create_frontend ? azurerm_app_service.frontend[0].default_site_hostname : data.azurerm_app_service.frontend.default_site_hostname
  backend_hostname   = var.create_backend  ? azurerm_app_service.backend[0].default_site_hostname  : data.azurerm_app_service.backend.default_site_hostname
}

# 🚀 Frontend App Service
resource "azurerm_app_service" "frontend" {
  count               = var.create_frontend ? 1 : 0
  name                = "vite-container-frontend"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = local.service_plan_id

  site_config {
    linux_fx_version = "DOCKER|${local.acr_login_server}/frontend:latest"
  }

  app_settings = {
    DOCKER_REGISTRY_SERVER_URL      = "https://${local.acr_login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = local.acr_admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = local.acr_admin_password
    DOCKER_ENABLE_CI                = true
  }
}

# 🚀 Backend App Service
resource "azurerm_app_service" "backend" {
  count               = var.create_backend ? 1 : 0
  name                = "express-container-backend"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = local.service_plan_id

  site_config {
    linux_fx_version = "DOCKER|${local.acr_login_server}/backend:latest"
  }

  app_settings = {
    DOCKER_REGISTRY_SERVER_URL      = "https://${local.acr_login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = local.acr_admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = local.acr_admin_password
    DOCKER_ENABLE_CI                = true
  }
}

# 🌐 Outputs for linking (optional)
output "frontend_url" {
  value = "https://${local.frontend_hostname}"
}

output "backend_url" {
  value = "https://${local.backend_hostname}/api"
}
