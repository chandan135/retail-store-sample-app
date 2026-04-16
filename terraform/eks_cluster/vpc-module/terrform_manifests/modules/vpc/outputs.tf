output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the custom vpc"
}

output "public_subnet_ids" {
  value       = [for subnet in aws_subnet.main_vpc_public_subnet : subnet.id]
  description = "List of all public subnets in custom vpc"
}

output "private_subnet_ids" {
  value       = [for subnet in aws_subnet.main_vpc_private_subnet : subnet.id]
  description = "List of all private subnets in custom vpc"
}

output "public_subnet_map" {
  value       = { for az, subnet in aws_subnet.main_vpc_public_subnet : az => subnet.id }
  description = "Map of AZ to Public Subnet ID"
}

output "private_subnet_map" {
  value       = { for az, subnet in aws_subnet.main_vpc_private_subnet : az => subnet.id }
  description = "Map of AZ to Private Subnet ID"
}

output "IGW" {
  value       = aws_internet_gateway.main_igw.id
  description = "ID of Internet Gateway in Custom VPC"
}
