provider "aws" {
  access_key = "AKIA5OEJXHVCVKJOCMWG"
  secret_key = "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"
  region = "ap-southeast-1"
}
resource "aws_instance" "resource_one" {
  ami = "ami-0fa377108253bf620"
  instance_type = "t2.micro"
  count = length(var.my_list)
  tags = {
	Name = "server-${count.index}"
}
}
variable "my_list" {
  default = ["zero","first","second"]
}

