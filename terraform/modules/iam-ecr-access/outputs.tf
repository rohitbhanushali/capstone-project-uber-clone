output "instance_profile_name" {
  description = "IAM instance profile name for ECR access"
  value       = aws_iam_instance_profile.instance_profile.name
}

output "role_name" {
  description = "IAM role name for ECR access"
  value       = aws_iam_role.ec2_role.name
}

output "role_arn" {
  description = "IAM role ARN for ECR access"
  value       = aws_iam_role.ec2_role.arn
}

output "policy_arn" {
  description = "Policy ARN for ECR access"
  value       = aws_iam_policy.ecr_access.arn
}