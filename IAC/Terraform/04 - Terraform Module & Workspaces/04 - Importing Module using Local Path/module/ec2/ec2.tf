terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.50"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "Terraform-Server" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "First-Terraform-Server"
  }
}

output "instance_id" {
  value = aws_instance.Terraform-Server.id
}