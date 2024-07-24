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

resource "aws_eip" "lb" {
  domain = "vpc"
}

output "public-ip" {
  value = "https://${aws_eip.lb.public_ip}:80"
}