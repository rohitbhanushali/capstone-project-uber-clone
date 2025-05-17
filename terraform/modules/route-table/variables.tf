variable "vpc_id" {
  description = "VPC ID for the route table"
  type        = string
}

variable "internet_gateway_id" {
  description = "Internet Gateway ID to route to"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs to associate with the public route table"
  type        = list(string)
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}
