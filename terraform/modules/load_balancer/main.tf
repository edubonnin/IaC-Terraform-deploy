resource "docker_image" "haproxy" {
  name = "haproxy:latest"
}

resource "docker_container" "haproxy" {
  name     = "load_balancer"
  image    = docker_image.haproxy.name
  restart  = "on-failure"
  must_run = true

  ports {
    internal = 80
    external = var.lb_port
  }

  networks_advanced {
    name    = var.network_name
    aliases = ["load_balancer"]
  }

  volumes {
    host_path      = abspath("${path.module}/haproxy.cfg")
    container_path = "/usr/local/etc/haproxy/haproxy.cfg"
  }
}