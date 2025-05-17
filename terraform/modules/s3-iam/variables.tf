variable "name_prefix" {
  description = "Prefix for naming IAM resources"
  type        = string
}

variable "bucket_name_prefix" {
  description = "Prefix for S3 bucket name"
  type        = string
}

variable "versioning_enabled" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = true
}
