resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = "${var.region}${each.key}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name_prefix}-public-subnet-${each.key}"
    Tier = "public"
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = "${var.region}${each.key}"

  tags = {
    Name = "${var.name_prefix}-private-subnet-${each.key}"
    Tier = "private"
  }
}
