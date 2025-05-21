terraform {
  backend "s3" {
    bucket       = "uber-clone-terraform-state"
    key          = "dev/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}