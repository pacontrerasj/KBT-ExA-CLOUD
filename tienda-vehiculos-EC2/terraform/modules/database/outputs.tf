output "rds_endpoint" {
  description = "Endpoint del RDS (solo hostname)"
  value       = aws_db_instance.rds.address
}

output "rds_port" {
  description = "Puerto del RDS"
  value       = aws_db_instance.rds.port
}

output "rds_id" {
  description = "Identificador del RDS"
  value       = aws_db_instance.rds.id
}

output "db_password" {
  description = "Password generado automaticamente para RDS"
  value       = random_password.master.result
  sensitive   = true
}
