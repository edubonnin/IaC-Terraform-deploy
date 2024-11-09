output "db_host" {
  value = docker_container.postgres.name # Nombre del contenedor
}

output "db_name" {
  value = var.db_name
}

output "db_user" {
  value = var.db_user
}

output "db_password" {
  value = var.db_password
}

output "db_port" {
  value = var.db_port
}