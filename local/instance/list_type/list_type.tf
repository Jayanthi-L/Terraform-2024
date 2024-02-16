provider "aws" {
  access_key = "AKIA5OEJXHVCVKJOCMWG"
  secret_key = "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"
  region     = "ap-southeast-1"
}
resource "aws_vpc" "lg_vpc" {
  cidr_block       = "20.20.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "lg-vpc"
  }
}
resource "aws_subnet" "lg_subnet" {
  vpc_id            = aws_vpc.lg_vpc.id
  cidr_block        = "20.20.0.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "lg-subnet"
  }
}
resource "aws_internet_gateway" "lg_igw" {
  vpc_id = aws_vpc.lg_vpc.id
  tags = {
    Name = "lg-igw"
  }
}
resource "aws_route_table" "lg_rtb" {
  vpc_id = aws_vpc.lg_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lg_igw.id
  }
  tags = {
    Name = "lg-rtb"
  }
}
resource "aws_route_table_association" "lg_rtb_association" {
  subnet_id      = aws_subnet.lg_subnet.id
  route_table_id = aws_route_table.lg_rtb.id
}
resource "aws_instance" "lg_instance" {
  ami                         = "ami-0fa377108253bf620"
  subnet_id                   = aws_subnet.lg_subnet.id
  key_name                    = "Hello"
  count                       = "1"
  availability_zone           = "ap-southeast-1a"
  associate_public_ip_address = "true"
  instance_type               = var.instance_type_list[0]
  tags = {
    Name = "lg-instance"
  }
}
variable "instance_type_list" {
  type    = list(any)
  default = ["t2.nano", "t2.micro", "t2.medium", "t2.large"]
}
