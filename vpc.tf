# --------- Setup the VPC -------------------------
resource "aws_vpc" "my-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name  = "My VPC"
    Stage = "Test"
  }
}
# --------- Setup an Internet Gateway --------------
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "My IGW"
  }
}
# --------- Setup a public subnet -------------------
resource "aws_subnet" "public-1" {
  vpc_id                  = aws_vpc.my-vpc.id
  map_public_ip_on_launch = true
  availability_zone       = var.public_availability_zone
  cidr_block              = var.public_subnet_cidr

  tags = {
    Name  = "Public-Subnet-1"
    Stage = "Test"
  }
}

# -------- Setup a route to the Internet ----------------
resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = {
    Name = "Public-Route"
  }
}
# ---------- associate internet route to public subnet ----
resource "aws_route_table_association" "public-1-assoc" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.public-route.id
}

