output "rds_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.primary.endpoint
}

output "rds_identifier" {
  description = "RDS identifier"
  value       = aws_db_instance.primary.id
}
