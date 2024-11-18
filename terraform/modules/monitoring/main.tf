# modules/monitoring/main.tf

resource "docker_image" "prometheus" {
  name = "prom/prometheus:latest"
}

resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = docker_image.prometheus.name

  ports {
    internal = 9090
    external = var.prometheus_port
  }

  volumes {
    host_path      = abspath("${path.module}/config/prometheus.yml")
    container_path = "/etc/prometheus/prometheus.yml"
  }

  networks_advanced {
    name    = var.network_name
    aliases = ["prometheus"]
  }
}

resource "docker_image" "grafana" {
  name = "grafana/grafana:latest"
}

resource "docker_container" "grafana" {
  name  = "grafana"
  image = docker_image.grafana.name

  ports {
    internal = 3000
    external = var.grafana_port
  }

  volumes {
    volume_name    = "vol_grafana"
    container_path = "/var/lib/grafana"
  }

  # Montaje de la carpeta de provisioning
  volumes {
    host_path      = abspath("${path.module}/grafana/provisioning")
    container_path = "/etc/grafana/provisioning"
  }

  # Montaje los dashboards
  volumes {
    host_path      = abspath("${path.module}/grafana/dashboards")
    container_path = "/var/lib/grafana/dashboards"
  }

  networks_advanced {
    name = var.network_name
  }
}

resource "docker_image" "cadvisor" {
  name = "gcr.io/cadvisor/cadvisor:latest"
}

resource "docker_container" "cadvisor" {
  name  = "cadvisor"
  image = docker_image.cadvisor.name

  ports {
    internal = 8080
    external = 8080
  }

  volumes {
    host_path      = "/"
    container_path = "/rootfs"
    read_only      = true
  }

  volumes {
    host_path      = "/var/run"
    container_path = "/var/run"
    read_only      = false
  }

  volumes {
    host_path      = "/sys"
    container_path = "/sys"
    read_only      = true
  }

  volumes {
    host_path      = "/var/lib/docker/"
    container_path = "/var/lib/docker"
    read_only      = true
  }

  networks_advanced {
    name    = var.network_name
    aliases = ["cadvisor"]
  }
}
