terraform {
  backend "s3" {
    bucket         = "uber-clone-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

module "uber_clone_infrastructure" {
  source = "../modules"

  environment = "dev"
  project     = "uber-clone"
  region      = "ap-south-1"
  key_name    = "uber-clone-key"

  # RDS Configuration
  rds_instance_class    = "db.t3.micro"
  rds_allocated_storage = 20
  rds_multi_az         = false
  rds_create_replica   = false

  # App Configuration
  app_instance_type  = "t2.micro"
  app_instance_count = 1

  # Monitoring Configuration
  enable_cloudwatch_alarms = true

  # IAM Configuration
  account_id = var.account_id

  tags = var.tags
}