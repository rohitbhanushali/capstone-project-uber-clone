output "public_sg_id" {
  value       = aws_security_group.public_sg.id
  description = "ID of the security group for public EC2"
}

output "private_sg_id" {
  value       = aws_security_group.private_sg.id
  description = "ID of the security group for private EC2"
}

output "rds_sg_id" {
  value       = aws_security_group.rds_sg.id
  description = "ID of the security group for RDS"
}
