output "vpc_id" {
  description = "ID de la VPC"
  value       = aws_vpc.vpc.id
}

output "subnet_publica_id" {
  description = "ID de la primera subnet publica"
  value       = aws_subnet.publica[0].id
}

output "subnets_privadas_ids" {
  description = "IDs de las subnets privadas"
  value       = aws_subnet.privada[*].id
}

output "sg_ec2_id" {
  description = "ID del Security Group de la EC2"
  value       = aws_security_group.sg_ec2.id
}

output "sg_rds_id" {
  description = "ID del Security Group de RDS"
  value       = aws_security_group.sg_rds.id
}
