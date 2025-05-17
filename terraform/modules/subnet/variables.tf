variable "vpc_id" {
  description = "The VPC ID where subnets will be created"
  type        = string
}

variable "region" {
  description = "AWS region (used to build AZs)"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "public_subnets" {
  description = "Map of public subnet AZ suffixes to CIDR blocks"
  type        = map(string)
}

variable "private_subnets" {
  description = "Map of private subnet AZ suffixes to CIDR blocks"
  type        = map(string)
}
