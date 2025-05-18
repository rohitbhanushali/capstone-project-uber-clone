variable "name" {
  description = "Name for the ECR repository"
  type        = string
  default     = "uber-clone"
}

variable "scan_on_push" {
  description = "Enable vulnerability scanning on image push"
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "Type of encryption for the ECR repository"
  type        = string
  default     = "AES256"
}

variable "tags" {
  description = "Tags to apply to ECR repository"
  type        = map(string)
  default     = {}
}