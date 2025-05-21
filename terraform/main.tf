module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = "10.0.0.0/16"
  name_prefix = "${var.project}-${var.environment}"
}

#----------------------------------------------------------------------------
module "subnet" {
  source      = "./modules/subnet"
  vpc_id      = module.vpc.vpc_id
  region      = var.region
  name_prefix = "${var.project}-${var.environment}"

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
  name_prefix         = "${var.project}-${var.environment}"
}

module "nat_gateway" {
  source             = "./modules/nat-gateway"
  vpc_id             = module.vpc.vpc_id
  public_subnet_id   = values(module.subnet.public_subnet_ids)[0]
  private_subnet_ids = module.subnet.private_subnet_ids
  name_prefix        = "${var.project}-${var.environment}"
}

#----------------------------------------------------------------------------
module "security_group" {
  source      = "./modules/security-group"
  vpc_id      = module.vpc.vpc_id
  name_prefix = "${var.project}-${var.environment}"
  ssh_cidrs   = ["0.0.0.0/0"] # Use tighter CIDRs in production!
  rds_port    = 5432
}

#----------------------------------------------------------------------------
# ECR Repository for Docker images
module "ecr" {
  source = "./modules/ecr"
}

# IAM Role for EC2 instances to access ECR
module "iam_ecr_access" {
  source      = "./modules/iam-ecr-access"
  name_prefix = "${var.project}-${var.environment}"
}

#----------------------------------------------------------------------------
# S3 Bucket and IAM role for application data
module "s3_iam" {
  source             = "./modules/s3-iam"
  name_prefix        = "${var.project}-${var.environment}"
  bucket_name_prefix = "${var.project}-${var.environment}"
  versioning_enabled = true
}

#----------------------------------------------------------------------------
# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "${var.project}-${var.environment}-alb-sg"
  description = "Allow HTTP traffic to ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project}-${var.environment}-alb-sg"
    Environment = var.environment
    Project     = var.project
  }
}

#----------------------------------------------------------------------------
# Bastion Host
module "bastion" {
  source                    = "./modules/ec2"
  ami_id                    = "ami-0e35ddab05955cf57"
  instance_type             = "t2.micro"
  instance_count            = 1
  subnet_ids                = values(module.subnet.public_subnet_ids)
  security_group_id         = module.security_group.public_sg_id
  key_name                  = var.key_name
  user_data                 = "./scripts/bastion-userdata.sh"
  name_prefix               = "${var.project}-${var.environment}"
  instance_role             = "bastion"
  iam_instance_profile_name = module.iam_ecr_access.instance_profile_name
  vpc_id                    = module.vpc.vpc_id
}

#----------------------------------------------------------------------------
# Application Servers
module "app_server" {
  source                    = "./modules/ec2"
  ami_id                    = "ami-0e35ddab05955cf57"
  instance_type             = "t2.micro"
  instance_count            = 2
  subnet_ids                = values(module.subnet.private_subnet_ids)
  security_group_id         = module.security_group.private_sg_id
  key_name                  = var.key_name
  user_data                 = "./scripts/app-userdata.sh"
  name_prefix               = "${var.project}-${var.environment}"
  instance_role             = "app"
  iam_instance_profile_name = module.iam_ecr_access.instance_profile_name
  vpc_id                    = module.vpc.vpc_id
}

#----------------------------------------------------------------------------
# RDS Database
module "rds" {
  source                 = "./modules/rds"
  name_prefix            = "${var.project}-${var.environment}"
  subnet_ids             = values(module.subnet.private_subnet_ids)
  security_group_id      = module.security_group.rds_sg_id
  engine                 = "postgres"
  instance_class         = var.environment == "prod" ? "db.t3.medium" : "db.t3.micro"
  allocated_storage      = var.environment == "prod" ? 50 : 20
  multi_az               = var.environment == "prod" ? true : false
  db_username            = "admin123"
  environment            = var.environment
  create_read_replica    = var.environment == "prod" ? true : false
  replica_instance_class = var.environment == "prod" ? "db.t3.medium" : "db.t3.micro"
}

#----------------------------------------------------------------------------
# Application Load Balancer
module "alb" {
  source              = "./modules/alb"
  name                = "${var.project}-${var.environment}-alb"
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = values(module.subnet.public_subnet_ids)
  security_group_id   = aws_security_group.alb_sg.id
  target_instance_ids = module.app_server.instance_ids

  tags = {
    Environment = var.environment
    Project     = var.project
  }
}

# Allow ALB to access app servers
resource "aws_security_group_rule" "allow_alb_to_ec2" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_server.instance_sg_id
  source_security_group_id = aws_security_group.alb_sg.id
  description              = "Allow HTTP traffic from ALB to app servers"
}