output "ec2_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.ec2.id
}

output "ec2_public_ip" {
  description = "IP publica fija (Elastic IP) de la EC2"
  value       = aws_eip.ec2.public_ip
}

output "ec2_public_dns" {
  description = "DNS publico de la EC2"
  value       = aws_instance.ec2.public_dns
}
