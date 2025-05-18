resource "aws_instance" "this" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index)
  key_name      = var.key_name
  iam_instance_profile = module.iam_ecr_access.instance_profile_name
  vpc_security_group_ids = [var.security_group_id]

  user_data = var.user_data != null && var.user_data != "" ? file(var.user_data) : null

  tags = {
    Name = "${var.name_prefix}-${var.instance_role}-${count.index + 1}"
    Role = var.instance_role
  }
}
