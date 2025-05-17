output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.subnet.public_subnet_ids
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}