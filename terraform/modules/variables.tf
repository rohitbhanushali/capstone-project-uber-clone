variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

# RDS Configuration
variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_allocated_storage" {
  description = "Allocated storage for RDS in GB"
  type        = number
  default     = 20
}

variable "rds_multi_az" {
  description = "Whether to create a multi-AZ RDS deployment"
  type        = bool
  default     = false
}

variable "rds_create_replica" {
  description = "Whether to create a read replica"
  type        = bool
  default     = false
}

variable "rds_replica_class" {
  description = "Instance class for RDS read replica"
  type        = string
  default     = "db.t3.micro"
}

# App Configuration
variable "app_instance_type" {
  description = "EC2 instance type for application servers"
  type        = string
  default     = "t2.micro"
}

variable "app_instance_count" {
  description = "Number of application instances"
  type        = number
  default     = 1
}

# Monitoring Configuration
variable "enable_cloudwatch_alarms" {
  description = "Whether to enable CloudWatch alarms"
  type        = bool
  default     = true
}

variable "alert_email" {
  description = "Email address for CloudWatch alerts"
  type        = string
}

# IAM Configuration
variable "account_id" {
  description = "AWS account ID"
  type        = string
}

# Tags
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
} 