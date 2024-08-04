# resource "aws_iam_user" "lb" {
#   name = var.username
# }

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "name" {
  ami                    = "ami-068e0f1a600cd311c"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-04164a83bd532b187"]
}