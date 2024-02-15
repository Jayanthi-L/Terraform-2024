resource "aws_instance" "sam_instance" {
   ami = "ami-0fa377108253bf620"
   subnet_id = aws_subnet.kia_subnet.id
   associate_public_ip_address = "true"
   key_name = "Hello"
   instance_type = var.instance_type_string
   availability_zone = "ap-southeast-1"
   tags = {
	Name = "sam_instance"
}
}
variable "instance_type_string" {
  type = string
  default = " "
}
