variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t3.micro"
}

variable "instance_count" {
  description = "Number of EC2 instances to launch"
  type        = number
  default     = 1
}

variable "subnet_ids" {
  description = "List of subnet IDs to place instances in"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the instance"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "user_data" {
  description = "Path to a user-data script (optional)"
  type        = string
  default     = ""
}

variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "instance_role" {
  description = "Role tag to indicate instance purpose (e.g. bastion, app)"
  type        = string
}
