terraform {
  backend "s3" {
    bucket         = "uber-clone-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

module "uber_clone_infrastructure" {
  source = "../../"
  
  # Override variables for dev environment
  environment = "dev"
  project     = "uber-clone"
  region      = "ap-south-1"
  key_name    = "mumbai-ec2-key"
  
  # Development-specific overrides
  rds_instance_class = "db.t3.micro"
  rds_multi_az       = false
  app_instance_type  = "t2.micro"
  app_instance_count = 2
}