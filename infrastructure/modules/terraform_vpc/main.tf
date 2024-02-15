provider "aws" {
  region = var.aws_region
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "vpc_1" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name    = "vpc_1"
    Project = var.project_name
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "gw_1" {
  vpc_id = aws_vpc.vpc_1.id

  tags = {
    Name    = "gw_1"
    Project = var.project_name
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "rt_1" {
  vpc_id = aws_vpc.vpc_1.id

  route {
    cidr_block = var.default_route
    gateway_id = aws_internet_gateway.gw_1.id
  }

  tags = {
    Name    = "rt_1"
    Project = var.project_name
  }
}

resource "aws_subnet" "pub_subnet" {
  vpc_id = aws_vpc.vpc_1.id
  cidr_block = var.pub_subnet
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "pub_subnet"
    Project = var.project_name
  }
}

resource "aws_route_table_association" "web_rt_assoc_pub" {
  route_table_id = aws_route_table.rt_1.id
  subnet_id = aws_subnet.pub_subnet.id
}

resource "aws_subnet" "priv_subnet" {
  vpc_id = aws_vpc.vpc_1.id
  cidr_block = var.priv_subnet
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "priv_subnet"
    Project = var.project_name
  }
}

resource "aws_route_table_association" "web_rt_assoc_priv" {
  route_table_id = aws_route_table.rt_1.id
  subnet_id = aws_subnet.priv_subnet.id
}

resource "aws_subnet" "db_subnet" {
  vpc_id = aws_vpc.vpc_1.id
  cidr_block = var.db_subnet
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "db subnet"
    Project = var.project_name
  }
}

resource "aws_route_table_association" "db_rt_assoc_priv" {
  route_table_id = aws_route_table.rt_1.id
  subnet_id = aws_subnet.db_subnet.id
}

resource "aws_subnet" "db_subnet_2" {
  vpc_id = aws_vpc.vpc_1.id
  cidr_block = var.db_subnet_2
  availability_zone = "us-west-2b"
  tags = {
    Name = "db subnet 2"
    Project = var.project_name
  }
}

resource "aws_route_table_association" "db_rt_assoc_priv_2" {
  route_table_id = aws_route_table.rt_1.id
  subnet_id = aws_subnet.db_subnet_2.id
}