resource "aws_vpc" "first-vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "first-vpc-from-tf"
  }
}
resource "aws_subnet" "first-vpc-subnet" {
  vpc_id     = aws_vpc.first-vpc.id
  cidr_block = "10.10.0.0/24"
  tags = {
    Name = "first-subnet-tf"
  }
}
