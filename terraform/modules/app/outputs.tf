output "app_container_names" {
  value = [for container in docker_container.web : container.name]
}