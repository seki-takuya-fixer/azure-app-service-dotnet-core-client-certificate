variable "name" {
}

variable "location" {
}

variable "resource_group_name" {
}

variable "tier" {
  default = "Basic"
}

variable "size" {
  default = "B1"
}

variable "docker_registry_server_url" {
  default = ""
}

variable "docker_registry_server_username" {
  default = ""
}

variable "docker_registry_server_password" {
  default = ""
}

variable "container_image" {
  default = "nginx:latest"
}
