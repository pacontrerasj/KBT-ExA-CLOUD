output "ecr_frontend_url" {
  description = "URL del repositorio ECR del frontend"
  value       = aws_ecr_repository.frontend.repository_url
}

output "ecr_backend_url" {
  description = "URL del repositorio ECR del backend"
  value       = aws_ecr_repository.backend.repository_url
}

output "ecr_frontend_name" {
  description = "Nombre del repositorio ECR del frontend"
  value       = aws_ecr_repository.frontend.name
}

output "ecr_backend_name" {
  description = "Nombre del repositorio ECR del backend"
  value       = aws_ecr_repository.backend.name
}
