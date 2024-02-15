terraform {
  required_providers{
  aws = {
    version = "~>4.0"
}
}
}
provider "aws"{
  access_key = "AKIA5OEJXHVC6PBFIKY5"
  secret_key = "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"
  region = "ap-south-1"
}
resource "aws_instance" "second-instance"{
  tags = {
    Name = "one_and_two"
    environment = "development"
    department = "devops"
}
  ami = var.ami
  instance_type = var.instance_type
  key_name = "terraform"
  count = 2
}
variable "ami"{
  default = " "
}
variable "instance_type" {
  default = " "
}
