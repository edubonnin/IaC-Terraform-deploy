resource "docker_image" "redis" {
  name = "redis:latest"
}

resource "docker_container" "redis" {
  image = docker_image.redis.name
  name  = var.cache_host
  ports {
    internal = 6379
    external = var.cache_port
  }
  networks_advanced {
    name    = var.network_name
    aliases = [var.cache_host]
  }
}