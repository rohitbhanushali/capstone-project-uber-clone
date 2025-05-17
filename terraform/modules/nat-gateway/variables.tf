variable "vpc_id" {
  description = "VPC ID where the NAT gateway will be created"
  type        = string
}

variable "public_subnet_id" {
  description = "Subnet ID where the NAT Gateway will be placed"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs to associate with private route table"
  type        = list(string)
}

variable "name_prefix" {
  description = "Prefix for resource naming"
  type        = string
}
