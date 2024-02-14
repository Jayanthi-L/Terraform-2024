terraform {
  required_providers {
    aws = { version = "~>4.0" }
    google = {
    }
  }
}
resource "local_file" "resource-one" {
  content  = "Hello Mahesh"
  filename = "a.txt"
}

