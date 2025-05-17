output "instance_ids" {
  value       = aws_instance.this[*].id
  description = "IDs of EC2 instances"
}

output "public_ips" {
  value       = [for i in aws_instance.this : i.public_ip]
  description = "Public IPs of EC2 instances"
}

output "private_ips" {
  value       = [for i in aws_instance.this : i.private_ip]
  description = "Private IPs of EC2 instances"
}
