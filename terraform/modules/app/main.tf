resource "docker_image" "web" {
  name = "web"
  build {
    context = abspath("${path.module}/../../../app/")
    tag     = ["web:develop"]
  }
}

resource "docker_container" "web" {
  count = var.app_count # Número de instancias

  name  = "web-${count.index}"
  image = docker_image.web.name
  env = [
    "FLASK_ENV=development",
    "DB_HOST=${var.db_host}",
    "DB_NAME=${var.db_name}",
    "DB_USER=${var.db_user}",
    "DB_PASSWORD=${var.db_password}",
    "CACHE_HOST=${var.cache_host}",
    "CACHE_PORT=${var.cache_port}"
  ]
  ports {
    internal = 5000
    # external = 5000 (No se expone el puerto ya que el LB maneja las conexiones)
  }
  volumes {
    volume_name    = "vol_web"
    container_path = "/app"
  }
  networks_advanced {
    name    = var.network_name
    aliases = ["web-${count.index}"]
  }
}