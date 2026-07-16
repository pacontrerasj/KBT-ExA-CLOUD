variable "proyecto" {
  description = "Nombre del proyecto"
  type        = string
}

variable "subnet_id" {
  description = "ID de la subnet publica donde desplegar la EC2"
  type        = string
}

variable "sg_ec2_id" {
  description = "ID del Security Group de la EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
}

variable "key_name" {
  description = "Nombre del Key Pair de EC2"
  type        = string
}

variable "db_host" {
  description = "Endpoint del RDS"
  type        = string
}

variable "db_user" {
  description = "Usuario de la base de datos"
  type        = string
}

variable "db_password" {
  description = "Contrasena de la base de datos"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
}

variable "db_port" {
  description = "Puerto de la base de datos"
  type        = string
}
