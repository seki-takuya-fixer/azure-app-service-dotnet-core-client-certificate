provider "azurerm" {
  version = "=2.10.0"
  features {}

  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

module "resource_group" {
  source = "../../modules/resource_group"

  name     = var.resource_group_name
  location = var.location
}

module "container_registry" {
  source              = "../../modules/container_registry"
  name                = var.app_service_name
  location            = var.location
  resource_group_name = module.resource_group.name
}

module "app_service" {
  source                          = "../../modules/app_service"
  name                            = var.app_service_name
  location                        = var.location
  resource_group_name             = module.resource_group.name
  docker_registry_server_url      = "https://${module.container_registry.url}"
  docker_registry_server_username = module.container_registry.admin_username
  docker_registry_server_password = module.container_registry.admin_password
  container_image                 = "${module.container_registry.url}/${var.container_image_name}"
}
