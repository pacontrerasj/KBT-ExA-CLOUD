variable "proyecto" {
  description = "Nombre del proyecto"
  type        = string
}

variable "subnet_ids" {
  description = "IDs de las subnets privadas para RDS"
  type        = list(string)
}

variable "sg_rds_id" {
  description = "ID del Security Group de RDS"
  type        = string
}

variable "db_master_user" {
  description = "Usuario master de RDS"
  type        = string
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
}
