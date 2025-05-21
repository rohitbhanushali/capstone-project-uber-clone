terraform {
  backend "s3" {
    bucket         = "uber-clone-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

module "uber_clone_infrastructure" {
  source = "../modules"

  environment = "prod"
  project     = "uber-clone"
  region      = "ap-south-1"
  key_name    = "uber-clone-key"

  # RDS Configuration
  rds_instance_class    = "db.t3.medium"
  rds_allocated_storage = 50
  rds_multi_az         = true
  rds_create_replica   = true
  rds_replica_class    = "db.t3.medium"

  # App Configuration
  app_instance_type  = "t2.medium"
  app_instance_count = 2

  # Monitoring Configuration
  enable_cloudwatch_alarms = true

  # IAM Configuration
  account_id = var.account_id

  tags = var.tags
}