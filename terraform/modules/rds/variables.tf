variable "name_prefix" {
  description = "Prefix to be used for resource names"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for RDS"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for RDS"
  type        = string
}

variable "engine" {
  description = "Database engine type"
  type        = string
  default     = "postgres"
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "Storage type for RDS"
  type        = string
  default     = "gp2"
}

variable "multi_az" {
  description = "Whether to create a multi-AZ deployment"
  type        = bool
  default     = false
}

variable "db_username" {
  description = "Database master username"
  type        = string
  default     = "postgres"
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "db_password" {
  description = "Master DB password"
  type        = string
  sensitive   = true
}

variable "create_read_replica" {
  description = "Whether to create a read replica"
  type        = bool
  default     = false
}

variable "replica_instance_class" {
  description = "Instance class for read replica"
  type        = string
  default     = "db.t3.micro"
}
