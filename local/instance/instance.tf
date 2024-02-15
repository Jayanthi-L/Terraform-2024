provider "aws" {
  access_key = "AKIA5OEJXHVC6PBFIKY5"
  secret_key = "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"
  region     = "ap-south-1"
}
resource "aws_instance" "first-instance" {
  ami           = "ami-03f4878755434977f"
  instance_type = "t2.micro"
  key_name      = "terraform"
  tags = {
    Name        = "First_instance_from_terraform"
    environment = "research_and_development"
    department  = "devops"
  }
}
