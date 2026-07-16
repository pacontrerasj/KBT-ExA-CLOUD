# ============================================================
# Variables globales — Tienda Vehiculos
# ============================================================

variable "aws_region" {
  description = "Region de AWS donde se desplegara la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "proyecto" {
  description = "Nombre del proyecto usado en naming y tags"
  type        = string
  default     = "tienda-vehiculos"
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Zonas de disponibilidad a usar"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "mi_ip" {
  description = "Tu IP publica en formato CIDR (ej: 201.123.45.67/32). Permite SSH a la EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Nombre del par de llaves EC2 (Key Pair) ya creado en AWS"
  type        = string
}

variable "db_master_user" {
  description = "Usuario master de la base de datos RDS"
  type        = string
  default     = "admin"
}

variable "db_master_password" {
  description = "Contrasena master de la base de datos RDS"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Nombre de la base de datos a crear en RDS"
  type        = string
  default     = "tienda_vehiculos"
}

variable "aws_account_id" {
  description = "ID de la cuenta AWS (12 digitos). Se usa para las URLs de ECR"
  type        = string
}
