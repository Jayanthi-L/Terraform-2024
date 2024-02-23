resource "aws_instance" "resource-one" {
  ami = var.ami
  instance_type = var.instance_type
  tags = {
	Name = var.name
}
}
variable "ami"{
 type = string
}
variable "instance_type"{
 type = string
}
variable "name"{
 type = string
}

