terraform {
  required_providers {
    aws = {
      version = "~>4.0"
    }
  }
}
provider "aws" {
  access_key = "AKIA5OEJXHVCVKJOCMWG"
  secret_key = "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"
  region     = "ap-southeast-1"
}
resource "aws_instance" "second-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = "Hello"
  count         = 2
  tags = {
    Name        = "oneandtwo"
    environment = "development"
    department  = "devops"
  }

}
variable "ami" {
  default = "ami-0fa377108253bf620"
}
variable "instance_type" {
  default = "t2.micro"
}
