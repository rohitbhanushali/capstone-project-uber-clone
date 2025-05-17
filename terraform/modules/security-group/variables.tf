variable "vpc_id" {
  description = "VPC ID for the security groups"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for security group names"
  type        = string
}

variable "ssh_cidrs" {
  description = "List of CIDR blocks allowed SSH access to bastion"
  type        = list(string)
}

variable "rds_port" {
  description = "Port for RDS (default 5432 for PostgreSQL)"
  type        = number
  default     = 5432
}
