provider "aws" {
  region = "ap-south-1"
}

/*
resource "aws_iam_user" "iam" {
  for_each = toset(["user-01", "user=02", "user-03"])
  name     = each.key
}
*/

data "aws_ami" "myImage" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = name
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "myEC2" {
  ami = data.aws_ami.myImage.id
  for_each = {
    key1 = "t2.micro"
    key2 = "t2.medium"
  }
  instance_type = each.value
  key_name      = each.key
  tags = {
    Name = each.value
  }
}