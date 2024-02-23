resource "aws_s3_bucket" "bucket"{
  bucket =var.bucket
  tags = {
	Name = var.name
	environment = var.environment
}
}
variable "bucket"{
  type = string
}
variable "name"{
 type = string
}
variable "environment"{
  type = string
}
