terraform {
  backend "s3" {
    bucket         = "uber-clone-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

module "uber_clone_infrastructure" {
  source = "../../"
  
  # Override variables for production environment
  environment = "prod"
  project     = "uber-clone"
  region      = "ap-south-1"
  key_name    = "mumbai-ec2-key"
  
  # Production-specific overrides - these values come from terraform.tfvars
}