provider "aws" {
  access_key = "AKIA5OEJXHVCVKJOCMWG"
  secret_key = "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"
  region     = "ap-southeast-1"
}
resource "aws_vpc" "kia_vpc" {
  cidr_block       = "30.30.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "kia-vpc-form-terraform"
  }
}
resource "aws_subnet" "kia_subnet" {
  vpc_id            = aws_vpc.kia_vpc.id
  cidr_block        = "30.30.0.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "kia-subnet-from-terraform"
  }
}
resource "aws_internet_gateway" "kia_igw" {
  vpc_id = aws_vpc.kia_vpc.id
  tags = {
    Name = "kia-igw"
  }
}
resource "aws_route_table" "kia_rtb" {
  vpc_id = aws_vpc.kia_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kia_igw.id
  }
  tags = {
    Name = "kia-rtb"
  }
}
resource "aws_route_table_association" "kia_rtb_association" {
  subnet_id      = aws_subnet.kia_subnet.id
  route_table_id = aws_route_table.kia_rtb.id
}
resource "aws_instance" "kia_instance" {
  ami                         = "ami-0fa377108253bf620"
  subnet_id                   = aws_subnet.kia_subnet.id
  count                       = "1"
  associate_public_ip_address = "true"
  instance_type               = "t2.micro"
  key_name                    = "Hello"
  availability_zone           = "ap-southeast-1a"
  tags = {
    Name = "kia-007"
  }
}
