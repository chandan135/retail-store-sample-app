# Resource 1 : VPC
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = merge(var.tags,{
    Name = "${var.environment_name}-vpc"
  })
  lifecycle {
    prevent_destroy = false # Make it "true" in prod environment
  }
}

# Resource 2 : IGW
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.tags,{
    Name = "${var.environment_name}-IGW"
  })
}
# Resource 3 : Public Subnets
resource "aws_subnet" "main_vpc_public_subnet" {
  for_each = { for idx, az in local.azs : az => local.public_subnets[idx]}
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
  map_public_ip_on_launch = true
  availability_zone = each.key
  tags = merge(var.tags,{
    Name = "${var.environment_name}-public-subnet-${each.key}"
  })
}
# Resource 4 : Private Subnets
resource "aws_subnet" "main_vpc_private_subnet" {
  for_each = { for idx, az in local.azs : az => local.private_subnets[idx]}
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
  availability_zone = each.key
  tags = merge(var.tags,{
    Name = "${var.environment_name}-private-subnet-${each.key}"
  })
}
# Resource 5 : EIP for NAT GW
resource "aws_eip" "main_vpc_eip_natgw" {
  tags = merge(var.tags,{
    Name = "${var.environment_name}-natgw-eip"
  })
}
# Resource 6 : NAT GW
resource "aws_nat_gateway" "main_vpc_natgw" {
  allocation_id = aws_eip.main_vpc_eip_natgw.id
  subnet_id     = values(aws_subnet.main_vpc_public_subnet)[0].id # Attaching the Nat gw in 1 public subnet
  tags = merge(var.tags,{
    Name = "${var.environment_name}-natgw"
  })
  depends_on = [aws_internet_gateway.main_igw]
}
# Resource 7 : Public Route Table
# Resource 8 : Public Route Table Assoicate to Public Subnet
# Resource 9 : Private Route Table
# Resource 10 : Private Route Table Assoicate to Public Subnet
