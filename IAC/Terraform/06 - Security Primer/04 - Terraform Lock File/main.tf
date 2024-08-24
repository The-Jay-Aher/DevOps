terraform {
  required_providers {
    aws = {
      version = "~>4.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "myEC2" {
  ami           = "ami-068e0f1a600cd311c"
  instance_type = "t2.micro"
}
