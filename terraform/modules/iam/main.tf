# IAM role for EC2 instances
resource "aws_iam_role" "ec2_role" {
  name = "${var.name_prefix}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "${var.name_prefix}-ec2-role"
  }
}

# IAM policy for SSM access
resource "aws_iam_policy" "ssm_policy" {
  name        = "${var.name_prefix}-ssm-policy"
  description = "Policy for SSM access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:UpdateInstanceInformation",
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ]
        Resource = "*"
      }
    ]
  })
}

# IAM policy for RDS access
resource "aws_iam_policy" "rds_policy" {
  name        = "${var.name_prefix}-rds-policy"
  description = "Policy for RDS access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "rds-db:connect",
          "secretsmanager:GetSecretValue"
        ]
        Resource = [
          "arn:aws:rds-db:${var.region}:${var.account_id}:dbuser:${var.rds_resource_id}/*",
          "arn:aws:secretsmanager:${var.region}:${var.account_id}:secret:${var.name_prefix}-*"
        ]
      }
    ]
  })
}

# Attach policies to role
resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ssm_policy.arn
}

resource "aws_iam_role_policy_attachment" "rds_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.rds_policy.arn
}

# Create instance profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.name_prefix}-ec2-profile"
  role = aws_iam_role.ec2_role.name
} 