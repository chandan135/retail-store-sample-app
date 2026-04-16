output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the custom vpc"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "List of all public subnets in custom vpc"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "List of all private subnets in custom vpc"
}

output "public_subnet_map" {
  value       = module.vpc.public_subnet_map
  description = "Map of AZ to Public Subnet ID"
}

output "private_subnet_map" {
  value       = module.vpc.private_subnet_map
  description = "Map of AZ to Private Subnet ID"
}

output "IGW" {
  value       = module.vpc.IGW
  description = "ID of Internet Gateway in Custom VPC"
}
