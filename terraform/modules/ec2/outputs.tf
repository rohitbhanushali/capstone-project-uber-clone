output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = [for instance in aws_instance.this : instance.id]
}

output "instance_sg_id" {
  description = "Security Group ID attached to the EC2 instances"
  value       = aws_security_group.this.id
}

output "public_ips" {
  value       = [for i in aws_instance.this : i.public_ip]
  description = "Public IPs of EC2 instances"
}

output "private_ips" {
  value       = [for i in aws_instance.this : i.private_ip]
  description = "Private IPs of EC2 instances"
}
