resource "azurerm_app_service_plan" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "Linux"
  reserved            = true
  sku {
    tier = var.tier
    size = var.size
  }
}

resource "azurerm_app_service" "this" {
  depends_on = [azurerm_app_service_plan.this]

  name                    = var.name
  location                = var.location
  app_service_plan_id     = azurerm_app_service_plan.this.id
  resource_group_name     = var.resource_group_name
  client_affinity_enabled = true
  https_only              = true
  site_config {
    always_on = true
    # app_command_line          = var.app_command_line
    linux_fx_version          = "DOCKER|${var.container_image}"
    ftps_state                = "Disabled"
    http2_enabled             = true
    use_32_bit_worker_process = false
  }
  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"      = "${var.docker_registry_server_url}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = "${var.docker_registry_server_username}"
    "DOCKER_REGISTRY_SERVER_PASSWORD" = "${var.docker_registry_server_password}"
  }
}
