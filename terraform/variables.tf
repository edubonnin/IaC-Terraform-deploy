# Variables de configuración de la base de datos
variable "db_host" {
  default = "db"
}

variable "db_name" {
  default = "usuarios"
}

variable "db_user" {
  default = "edu"
}

variable "db_password" {
  default = "0000"
}

variable "db_port" {
  default = 5432
}

# Variables de configuración de la caché
variable "cache_host" {
  default = "cache"
}

variable "cache_port" {
  default = 6379
}

# Variables para el balanceador de carga
variable "lb_port" {
  default = 80
}

variable "lb_policy" {
  default = "roundrobin" # "leastconn", "source", etc.
}

variable "app_count" {
  default = 3 # Número de instancias de la aplicación
}