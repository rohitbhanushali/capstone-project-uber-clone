resource "aws_iam_policy" "ecr_access" {
  name        = "${var.name_prefix}-ecr-access-policy"
  description = "Policy to allow EC2 instance to access ECR"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "ec2_role" {
  name = "${var.name_prefix}-ecr-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecr_access_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ecr_access.arn
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.name_prefix}-ecr-instance-profile"
  role = aws_iam_role.ec2_role.name
}
