################################################################################################################################
#                                                  VPC 
################################################################################################################################

resource "aws_vpc" "website-monitoring" {
  cidr_block = var.vpc-cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "Website Monitoring VPC"
  }
}

################################################################################################################################
#                                               VPC Subnet
################################################################################################################################

resource "aws_subnet" "website-monitoring-public-subnet" {
  vpc_id = aws_vpc.website-monitoring.id
  cidr_block = var.public-subnet-cidr
  availability_zone = var.az1
  map_public_ip_on_launch = true
  tags = {
    Name = "Website Monitorin Public Subnet"
  }
}

resource "aws_subnet" "website-monitoring-private-subnet" {
  vpc_id = aws_vpc.website-monitoring.id
  cidr_block = var.private-subnet-cidr
  availability_zone = var.az1
  tags = {
    Name = "Website Monitoring Private Subnet"
  }
}


################################################################################################################################
#                                           VPC Internet Gateway
################################################################################################################################

resource "aws_internet_gateway" "website-monitoring-igw" {
  vpc_id = aws_vpc.website-monitoring.id
  tags = {
    Name = "Website Monitoring IGW"
  }
}


################################################################################################################################
#                                               VPC NAT Gateway
################################################################################################################################


resource "aws_eip" "nat-eip" {
  domain = "vpc"
  tags = {
    Name = "NAT-EIP"
  }
}

resource "aws_nat_gateway" "website-monitoring-eip" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id = aws_subnet.website-monitoring-public-subnet.id
  tags = {
    Name = "Website Monitoring NAT"
  }
}

################################################################################################################################
#                                               VPC Route Table
################################################################################################################################

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.website-monitoring.id
  route {
    gateway_id = aws_internet_gateway.website-monitoring-igw.id
    cidr_block = var.anywhere-ip
  }
}

resource "aws_route_table" "private-route-table" {
    vpc_id = aws_vpc.website-monitoring.id
    route {
        gateway_id = aws_nat_gateway.website-monitoring-eip.id
        cidr_block = var.anywhere-ip
    }
}


################################################################################################################################
#                                           VPC Route Table Association
################################################################################################################################

resource "aws_route_table_association" "public-rt-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id = aws_subnet.website-monitoring-public-subnet.id
}

resource "aws_route_table_association" "private-rt-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id = aws_subnet.website-monitoring-private-subnet.id
}