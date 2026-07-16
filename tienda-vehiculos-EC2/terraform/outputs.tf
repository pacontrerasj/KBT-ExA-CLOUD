# ============================================================
# Outputs — Tienda Vehiculos
# ============================================================

output "ec2_public_ip" {
  description = "IP publica de la instancia EC2"
  value       = module.compute.ec2_public_ip
}

output "ec2_public_dns" {
  description = "DNS publico de la instancia EC2"
  value       = module.compute.ec2_public_dns
}

output "rds_endpoint" {
  description = "Endpoint de la base de datos RDS"
  value       = module.database.rds_endpoint
}

output "rds_port" {
  description = "Puerto de la base de datos RDS"
  value       = module.database.rds_port
}

output "ecr_frontend_url" {
  description = "URL del repositorio ECR para el frontend"
  value       = module.ecr.ecr_frontend_url
}

output "ecr_backend_url" {
  description = "URL del repositorio ECR para el backend"
  value       = module.ecr.ecr_backend_url
}

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.networking.vpc_id
}
