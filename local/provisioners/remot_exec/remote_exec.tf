provider "aws" {
  access_key = "AKIA5OEJXHVCVKJOCMWG"
  secret_key = "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"
  region     = "ap-southeast-1"
}
resource "aws_instance" "provisioner_instance" {
  ami           = "ami-0fa377108253bf620"
  instance_type = "t2.micro"
  key_name      = "Hello"
  tags = {
    Name = "remote-exec"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/ubuntu/Hello.pem")
    host        = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "curl ifconfig.me",
      "whoami"
    ]
  }

}
