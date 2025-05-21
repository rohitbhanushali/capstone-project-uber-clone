variable "name_prefix" {
  description = "Prefix to be used for resource names"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "rds_resource_id" {
  description = "RDS resource ID for IAM authentication"
  type        = string
} 