variable "network_name" {
  type = string
}

variable "app_instances" {
  type = list(string)
}

variable "lb_port" {
  type    = number
}

variable "lb_policy" {
  type    = string
}