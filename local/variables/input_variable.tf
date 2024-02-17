provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}
resource "aws_vpc" "mi_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "mi-vpc"
  }
}
resource "aws_subnet" "mi_subnet" {
  vpc_id            = aws_vpc.mi_vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = "mi-subnet"
  }
}
resource "aws_internet_gateway" "mi_igw" {
  vpc_id = aws_vpc.mi_vpc.id
  tags = {
    Name = "mi-igw"
  }
}
resource "aws_route_table" "mi_rtb" {
  vpc_id = aws_vpc.mi_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mi_igw.id
  }
  tags = {
    Name = "mi-rtb"
  }
}
resource "aws_route_table_association" "mi_rtb_association" {
  subnet_id      = aws_subnet.mi_subnet.id
  route_table_id = aws_route_table.mi_rtb.id
}
resource "aws_instance" "mi_instance" {
  ami                         = var.ami
  key_name                    = var.key_name
  associate_public_ip_address = "true"
  availability_zone           = "ap-southeast-1a"
  count                       = var.number_of_instance
  subnet_id                   = aws_subnet.mi_subnet.id
  instance_type               = var.instance_type_map["small"]
  tags = {
    Name = "mi-instance"
  }
}
variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}
variable "region" {
  type = string
}
variable "vpc_cidr_block" {
  type    = string
  default = "40.40.0.0/16"
}
variable "subnet_cidr_block" {
  type    = string
  default = "40.40.0.0/24"
}
variable "availability_zone" {
  type    = string
  default = "ap-southeast-1a"
}
variable "ami" {
  type = string
}
variable "key_name" {
  type = string
}
variable "number_of_instance" {
  type    = string
  default = "1"
}
variable "instance_type_map" {
  type = map(any)
  default = ({
    small  = "t2.micro"
    medium = "t2.medium"
    large  = "t2.large"
  })
}
output "vpc_id" {
  value = aws_vpc.mi_vpc.id
}
output "subnet_id" {
  value = aws_subnet.mi_subnet.id
}
data "aws_instance" "teraform-ws" {
  instance_id = "i-08f555c4bd6e16ef3"
}
output "public_ip_teraform-ws" {
  value = data.aws_instance.teraform-ws
}
