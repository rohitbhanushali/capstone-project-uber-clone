# Create KMS key for RDS encryption
resource "aws_kms_key" "rds" {
  description             = "KMS key for RDS encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name = "${var.name_prefix}-rds-kms-key"
  }
}

resource "aws_kms_alias" "rds" {
  name          = "alias/${var.name_prefix}-rds-kms-key"
  target_key_id = aws_kms_key.rds.key_id
}

resource "aws_db_subnet_group" "rds" {
  name       = "${var.name_prefix}-rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.name_prefix}-rds-subnet-group"
  }
}

# Create a random password for the database
resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Store the password in AWS Secrets Manager
resource "aws_secretsmanager_secret" "db_password" {
  name = "${var.name_prefix}-db-password"
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = random_password.db_password.result
}

# Create a parameter group for PostgreSQL
resource "aws_db_parameter_group" "postgres" {
  family = "postgres13"
  name   = "${var.name_prefix}-postgres-params"

  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name  = "log_disconnections"
    value = "1"
  }

  parameter {
    name  = "log_min_duration_statement"
    value = "1000"
  }

  tags = {
    Name = "${var.name_prefix}-postgres-params"
  }
}

resource "aws_db_instance" "primary" {
  identifier              = "${var.name_prefix}-rds-primary"
  engine                  = var.engine
  engine_version          = "13.7"
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  username                = var.db_username
  password                = random_password.db_password.result
  db_subnet_group_name    = aws_db_subnet_group.rds.name
  vpc_security_group_ids  = [var.security_group_id]
  multi_az                = var.multi_az
  skip_final_snapshot     = true
  publicly_accessible     = false
  backup_retention_period = var.environment == "prod" ? 7 : 1
  backup_window           = "03:00-04:00"
  maintenance_window      = "Mon:04:00-Mon:05:00"
  storage_encrypted       = true
  kms_key_id              = var.environment == "prod" ? aws_kms_key.rds.arn : null
  parameter_group_name    = aws_db_parameter_group.postgres.name
  deletion_protection     = var.environment == "prod" ? true : false

  tags = {
    Name = "${var.name_prefix}-rds"
  }
}

resource "aws_db_instance" "read_replica" {
  count                     = var.create_read_replica ? 1 : 0
  identifier                = "${var.name_prefix}-rds-replica"
  replicate_source_db       = aws_db_instance.primary.id
  instance_class            = var.replica_instance_class
  db_subnet_group_name      = aws_db_subnet_group.rds.name
  vpc_security_group_ids    = [var.security_group_id]
  publicly_accessible       = false
  storage_encrypted         = true
  kms_key_id                = var.environment == "prod" ? aws_kms_key.rds.arn : null
  parameter_group_name      = aws_db_parameter_group.postgres.name
  deletion_protection       = var.environment == "prod" ? true : false
  depends_on                = [aws_db_instance.primary]

  tags = {
    Name = "${var.name_prefix}-rds-replica"
  }
}
