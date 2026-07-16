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
  description = "Tu IP publica en formato CIDR (ej: 201.123.45.67/32). Permite SSH a la EC2"
  type        = string

  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+/[0-9]+$", var.mi_ip))
    error_message = "mi_ip debe ser una IP valida en formato CIDR (ej: 201.123.45.67/32)."
  }
}
