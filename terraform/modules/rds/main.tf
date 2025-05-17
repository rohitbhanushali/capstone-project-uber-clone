resource "aws_db_subnet_group" "rds" {
  name       = "${var.name_prefix}-rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.name_prefix}-rds-subnet-group"
  }
}

resource "aws_db_instance" "primary" {
  identifier              = "${var.name_prefix}-rds-primary"
  engine                  = var.engine
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.rds.name
  vpc_security_group_ids  = [var.security_group_id]
  multi_az                = var.multi_az
  skip_final_snapshot     = true
  publicly_accessible     = false

  tags = {
    Name = "${var.name_prefix}-rds"
  }
}
