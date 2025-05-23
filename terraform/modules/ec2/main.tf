resource "aws_security_group" "this" {
  name_prefix = "${var.name_prefix}-${var.instance_role}-"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-${var.instance_role}-sg"
  }
}

resource "aws_instance" "this" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index % length(var.subnet_ids))
  key_name      = var.key_name
  iam_instance_profile = var.iam_instance_profile_name
  vpc_security_group_ids = [aws_security_group.this.id]

  user_data = var.user_data != null && var.user_data != "" ? file(var.user_data) : null

  tags = {
    Name = "${var.name_prefix}-${var.instance_role}-${count.index + 1}"
    Role = var.instance_role
  }
}