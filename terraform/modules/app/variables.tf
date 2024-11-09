variable "network_name" {
  type = string
}

variable "db_host" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type = string
}

variable "cache_host" {
  type = string
}

variable "cache_port" {
  type = number
}

# Número de instancias de la aplicación
variable "app_count" {
  type    = number
}