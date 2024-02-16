provider "aws" {
  access_key = "AKIA5OEJXHVCVKJOCMWG"
  secret_key = "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"
  region     = "ap-southeast-1"
}
resource "aws_vpc" "mango_vpc" {
  cidr_block       = "40.40.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "mango-vpc"
  }
}
resource "aws_subnet" "mango_subnet" {
  vpc_id            = aws_vpc.mango_vpc.id
  cidr_block        = "40.40.0.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "mango-subnet"
  }
}
resource "aws_internet_gateway" "mango_igw" {
  vpc_id = aws_vpc.mango_vpc.id
  tags = {
    Name = "mango-igw"
  }
}
resource "aws_route_table" "mango_rtb" {
  vpc_id = aws_vpc.mango_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mango_igw.id
  }
  tags = {
    Name = "mango-rtb"
  }
}
resource "aws_route_table_association" "mango_rtb_association" {
  subnet_id      = aws_subnet.mango_subnet.id
  route_table_id = aws_route_table.mango_rtb.id
}
resource "aws_instance" "mango_instance" {
  ami                         = "ami-0fa377108253bf620"
  subnet_id                   = aws_subnet.mango_subnet.id
  count                       = "1"
  key_name                    = "Hello"
  associate_public_ip_address = "true"
  availability_zone           = "ap-southeast-1a"
  instance_type               = var.instance_type_String
  tags = {
    Name = "Mango-instance"
  }
}
variable "instance_type_string" {
  type    = String
  default = "t2.micro "
}
