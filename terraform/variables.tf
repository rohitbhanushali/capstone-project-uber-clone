variable "environment" {
  description = "Environment name (dev/prod)"
  type        = string
  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be either 'dev' or 'prod'."
  }
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "uber-clone"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "key_name" {
  description = "SSH key name for EC2 instances"
  type        = string
  default     = "mumbai-ec2-key"
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
  validation {
    condition     = can(regex("^[0-9]{12}$", var.aws_account_id))
    error_message = "AWS Account ID must be 12 digits."
  }
}

variable "alert_email" {
  description = "Email for alerts"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.alert_email))
    error_message = "Invalid email format."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.vpc_cidr))
    error_message = "Invalid CIDR block format."
  }
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  validation {
    condition     = can(regex("^db\\.[a-z0-9]+\\.[a-z0-9]+$", var.rds_instance_class))
    error_message = "Invalid RDS instance class format."
  }
}

variable "app_instance_type" {
  description = "EC2 instance type for application servers"
  type        = string
  validation {
    condition     = can(regex("^t[0-9]+\\.[a-z0-9]+$", var.app_instance_type))
    error_message = "Invalid EC2 instance type format."
  }
}

variable "app_instance_count" {
  description = "Number of application instances"
  type        = number
  validation {
    condition     = var.app_instance_count >= 1 && var.app_instance_count <= 10
    error_message = "App instance count must be between 1 and 10."
  }
}

variable "rds_multi_az" {
  description = "Enable Multi-AZ deployment for RDS"
  type        = bool
  default     = false
}

variable "bastion_enabled" {
  description = "Enable bastion host"
  type        = bool
  default     = true
}

variable "enable_enhanced_monitoring" {
  description = "Enable enhanced monitoring for RDS"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Number of days to retain RDS backups"
  type        = number
  default     = 7
  validation {
    condition     = var.backup_retention_period >= 0 && var.backup_retention_period <= 35
    error_message = "Backup retention period must be between 0 and 35 days."
  }
}

variable "create_read_replica" {
  description = "Create RDS read replica"
  type        = bool
  default     = false
}