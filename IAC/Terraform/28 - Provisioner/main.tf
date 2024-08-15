provider "aws" {
  region = "ap-south-1"
}

data "aws_ami" "myImage" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = name
    values = [ "" ]
  }
}