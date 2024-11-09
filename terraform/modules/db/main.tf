resource "docker_image" "postgres" {
  name = "postgres:latest"
}

resource "docker_container" "postgres" {
  image = docker_image.postgres.name
  name  = var.db_host
  env = [
    "POSTGRES_DB=${var.db_name}",
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}"
  ]
  ports {
    internal = 5432
    external = var.db_port
  }
  networks_advanced {
    name    = var.network_name
    aliases = [var.db_host]
  }
}