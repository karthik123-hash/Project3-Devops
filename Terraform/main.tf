provider "aws" {
  region = "us-east-1"
}

# creating VPC 
resource "aws_vpc" "my-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Project3-VPC"
  }
}

# creating subnet 1
resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.192.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-1"
  }
}

# creating subnet 1
resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.224.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-2"
  }
}


# creating internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "My-Internet-Gateway"
  }
}

# creating route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my-vpc.id
}

# creating route in the route table
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}

# associating route table with subnet 1
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}