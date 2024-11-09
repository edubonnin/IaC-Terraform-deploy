output "cache_host" {
  value = docker_container.redis.name
}

output "cache_port" {
  value = var.cache_port
}