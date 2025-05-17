# S3 Bucket
resource "aws_s3_bucket" "app_bucket" {
  bucket = "${var.bucket_name_prefix}-${random_id.rand.hex}"
  force_destroy = true

  tags = {
    Name = "${var.bucket_name_prefix}-bucket"
  }
}

resource "random_id" "rand" {
  byte_length = 4
}

# Enable Versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.app_bucket.id

  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

# IAM Role for EC2 to Access S3
resource "aws_iam_role" "s3_access_role" {
  name = "${var.name_prefix}-s3-access-role"

  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# IAM Policy for S3 Access
resource "aws_iam_policy" "s3_access_policy" {
  name = "${var.name_prefix}-s3-access-policy"

  policy = data.aws_iam_policy_document.s3_access.json
}

data "aws_iam_policy_document" "s3_access" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [
      aws_s3_bucket.app_bucket.arn,
      "${aws_s3_bucket.app_bucket.arn}/*"
    ]
  }
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.s3_access_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

# Instance Profile
resource "aws_iam_instance_profile" "s3_profile" {
  name = "${var.name_prefix}-s3-profile"
  role = aws_iam_role.s3_access_role.name
}
