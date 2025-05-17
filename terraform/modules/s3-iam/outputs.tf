output "bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.app_bucket.bucket
}

output "iam_role_name" {
  description = "Name of IAM role with S3 access"
  value       = aws_iam_role.s3_access_role.name
}

output "instance_profile_name" {
  description = "Name of IAM instance profile"
  value       = aws_iam_instance_profile.s3_profile.name
}
