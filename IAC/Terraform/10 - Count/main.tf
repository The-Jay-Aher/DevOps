provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "myEC2" {
  ami = "ami-068e0f1a600cd311c"
  instance_type = "t2.micro"
  count = 3 # This is will 3 equal instances with same properties
}