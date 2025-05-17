module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = "10.0.0.0/16"
  name_prefix = "demo"
}


#----------------------------------------------------------------------------
module "subnet" {
  source      = "./modules/subnet"
  vpc_id      = module.vpc.vpc_id
  region      = "ap-south-1"
  name_prefix = "demo"

  public_subnets = {
    "a" = "10.0.1.0/24"
    "b" = "10.0.2.0/24"
  }

  private_subnets = {
    "a" = "10.0.101.0/24"
    "b" = "10.0.102.0/24"
    "c" = "10.0.103.0/24"
  }
}


#----------------------------------------------------------------------------
module "route_table" {
  source              = "./modules/route-table"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.vpc.igw_id
  public_subnet_ids   = module.subnet.public_subnet_ids
  name_prefix         = "demo"
}


module "nat_gateway" {
  source             = "./modules/nat-gateway"
  vpc_id             = module.vpc.vpc_id
  public_subnet_id   = module.subnet.public_subnet_ids[0]
  private_subnet_ids = module.subnet.private_subnet_ids
  name_prefix        = "demo"
}


#----------------------------------------------------------------------------
module "security_group" {
  source      = "./modules/security-group"
  vpc_id      = module.vpc.vpc_id
  name_prefix = "demo"
  ssh_cidrs   = ["0.0.0.0/0"] # Use tighter CIDRs in production!
  rds_port    = 5432
}


#----------------------------------------------------------------------------
module "bastion" {
  source            = "./modules/ec2"
  ami_id            = "ami-0abcd1234example"
  instance_type     = "t2.micro"
  instance_count    = 1
  subnet_ids        = module.subnet.public_subnet_ids
  security_group_id = module.security_group.public_sg_id
  key_name          = "my-key"
  user_data         = "./scripts/bastion-userdata.sh"
  name_prefix       = "demo"
  instance_role     = "bastion"
}


module "app_server" {
  source            = "./modules/ec2"
  ami_id            = "ami-0e35ddab05955cf57"
  instance_type     = "t2.micro"
  instance_count    = 2
  subnet_ids        = module.subnet.private_subnet_ids
  security_group_id = module.security_group.private_sg_id
  key_name          = "mumbai-ec2-key"
  user_data         = "./scripts/app-userdata.sh"
  name_prefix       = "demo"
  instance_role     = "app"
}

#----------------------------------------------------------------------------
module "rds" {
  source            = "./modules/rds"
  name_prefix       = "demo"
  subnet_ids        = module.subnet.private_subnet_ids
  security_group_id = module.security_group.rds_sg_id
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  db_username       = "admin"
  db_password       = "admin" # Use vaults/SSM in real setups
}


#----------------------------------------------------------------------------
module "s3_iam" {
  source             = "./modules/s3-iam"
  name_prefix        = "demo"
  bucket_name_prefix = "demo-app"
  versioning_enabled = true
}


#----------------------------------------------------------------------------
