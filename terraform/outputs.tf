output "frontend_url" {
  value = azurerm_app_service.frontend.default_site_hostname
}

output "backend_url" {
  value = azurerm_app_service.backend.default_site_hostname
}
