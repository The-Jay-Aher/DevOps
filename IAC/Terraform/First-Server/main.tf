terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "myFirstInstance" {
  ami = "ami-0ec0e125bb6c6e8ec"
  instance_type = "t2.micro"
  
  tags = {
    Name = "Terraform Server"
  }
}

