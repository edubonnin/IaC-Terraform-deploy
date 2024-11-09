# Docker provider
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Creación Docker network
resource "docker_network" "app_network" {
  name = "app_network"
}

module "db" {
  source       = "./modules/db"
  network_name = docker_network.app_network.name

  db_host     = var.db_host
  db_name     = var.db_name
  db_user     = var.db_user
  db_password = var.db_password
  db_port     = var.db_port
}

module "cache" {
  source       = "./modules/cache"
  network_name = docker_network.app_network.name

  cache_host = var.cache_host
  cache_port = var.cache_port
}


module "app" {
  source       = "./modules/app"
  network_name = docker_network.app_network.name

  db_host     = module.db.db_host
  db_name     = module.db.db_name
  db_user     = module.db.db_user
  db_password = module.db.db_password

  cache_host = module.cache.cache_host
  cache_port = module.cache.cache_port

  app_count = var.app_count

  depends_on = [module.db, module.cache]
}

# Obtener los nombres de los contenedores de la aplicación
output "app_container_names" {
  value = module.app.app_container_names
}

module "load_balancer" {
  source       = "./modules/load_balancer"
  network_name = docker_network.app_network.name

  app_instances = module.app.app_container_names
  lb_port       = var.lb_port
  lb_policy     = var.lb_policy

  depends_on = [module.app]
}

module "monitoring" {
  source       = "./modules/monitoring"
  network_name = docker_network.app_network.name

  depends_on = [module.app, module.load_balancer]
}