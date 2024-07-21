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

resource "aws_eip" "IP1" {
  domain = "vpc"
}

resource "aws_instance" "Instance1" {
  instance_type = "t2.micro"
  ami = "ami-"
}