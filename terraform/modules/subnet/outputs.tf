output "public_subnet_ids" {
  value = { for subnet in aws_subnet.public : subnet.availability_zone => subnet.id }
}

output "private_subnet_ids" {
  value = { for subnet in aws_subnet.private : subnet.availability_zone => subnet.id }
}