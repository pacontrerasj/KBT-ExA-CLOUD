variable "proyecto" {
  description = "Nombre del proyecto"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  type        = string
}

variable "azs" {
  description = "Zonas de disponibilidad"
  type        = list(string)
}

variable "mi_ip" {
  description = "IP publica para SSH en formato CIDR"
  type        = string
}
