provider "aws" {
  region = "ap-south-1"
}

variable "dev_names" {
  type = list(string)
  default = [ "alice", "bob", "john", "jones", "william" ]
}

resource "aws_instance" "myEC2" {
  ami = "ami-068e0f1a600cd311c"
  instance_type = "t2.micro"
  count = 3 # This is will 3 equal instances with same properties

  tags = {
    Name = "payment-system-${count.index}" # This line will ensure that each instance created will have a different name tag
  }
}

resource "aws_iam_user" "this" {
  # name = "developer-user.${count.index}"
  name = var.dev_names[count.index]
  count = 3
}