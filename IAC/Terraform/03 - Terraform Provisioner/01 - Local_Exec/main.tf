/*
provider "aws" {
  region = "ap-south-1"
}
*/

data "aws_ami" "myImage" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "myEC2" {
  ami           = "ami-0ae8f15ae66fe8cda"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> server_ip.txt"
  }
}

output "values" {
  value = data.aws_ami.myImage.id == aws_instance.myEC2.ami ? 1 : 0
}