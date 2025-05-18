output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.subnet.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.subnet.private_subnet_ids
}

output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = module.bastion.public_ips[0]
}

output "app_private_ips" {
  description = "Private IPs of the application servers"
  value       = module.app_server.private_ips
}

output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = module.rds.rds_endpoint
}

output "rds_identifier" {
  description = "Identifier of the RDS instance"
  value       = module.rds.rds_identifier
}

output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = module.alb.alb_dns_name
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket for application data"
  value       = module.s3_iam.bucket_name
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = module.ecr.repository_url
}

output "ssh_to_bastion" {
  description = "Command to SSH to the bastion host"
  value       = "ssh -i ~/.ssh/${var.key_name}.pem ubuntu@${module.bastion.public_ips[0]}"
}

output "ssh_to_app_via_bastion" {
  description = "Commands to SSH to app servers through the bastion"
  value       = [
    for ip in module.app_server.private_ips : 
    "ssh -i ~/.ssh/${var.key_name}.pem -J ubuntu@${module.bastion.public_ips[0]} ubuntu@${ip}"
  ]
}

output "app_url" {
  description = "URL to access the application"
  value       = "http://${module.alb.alb_dns_name}"
}