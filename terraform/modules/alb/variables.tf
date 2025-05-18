variable "name" {
  description = "Name of the ALB"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group ID for ALB"
  type        = string
}

variable "target_instance_ids" {
  description = "List of EC2 instance IDs to attach"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
