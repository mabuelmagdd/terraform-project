######## VPC #######
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "Main VPC"
  }
}
######## IGW and Route Table #######
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "InternetGW"
  }
}
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "Main Route Table"
  }
}
resource "aws_route_table_association" "pub1-association" {
  subnet_id = aws_subnet.AZ1_pub_subnet.id
  route_table_id = aws_route_table.main.id
}
resource "aws_route_table_association" "pub2-association" {
  subnet_id = aws_subnet.AZ2_pub_subnet.id
  route_table_id = aws_route_table.main.id
}
resource "aws_route_table_association" "priv1-association" {
  subnet_id = aws_subnet.AZ1_priv_subnet.id
  route_table_id = aws_route_table.main.id
}
resource "aws_route_table_association" "priv2-association" {
  subnet_id = aws_subnet.AZ2_priv_subnet.id
  route_table_id = aws_route_table.main.id
}


######## AZ1 Public and Private Subnets #######
resource "aws_subnet" "AZ1_pub_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.az1_pub_subnet_cidr_block
  availability_zone = var.az1
  map_public_ip_on_launch = true
  tags = {
    Name = "AZ1 Public Subnet"
  }
}
resource "aws_subnet" "AZ1_priv_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.az1_priv_subnet_cidr_block
  availability_zone = var.az1
  map_public_ip_on_launch = true
  tags = {
    Name = "AZ1 Private Subnet"
  }
}
######## AZ2 Public and Private Subnets #######
resource "aws_subnet" "AZ2_pub_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.az2_pub_subnet_cidr_block
  availability_zone = var.az2
  map_public_ip_on_launch = true
  tags = {
    Name = "AZ2 Public Subnet"
  }
}
resource "aws_subnet" "AZ2_priv_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.az2_priv_subnet_cidr_block
  availability_zone = var.az2
  map_public_ip_on_launch = true
  tags = {
    Name = "AZ2 Private Subnet"
  }
}
