terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "Terraform-Server" {
  ami                    = "ami-068e0f1a600cd311c"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Security-Group-1]
  tags = {
    Name = "First-Terraform-Server"
  }

  user_data = <<-EOF
      #!/bin/bash
      echo "Hello, World!" > index.html
      nohup busybox httpd -f -p 8080 &
      EOF

}

resource "aws_security_group" "Security-Group-1" {
  name = "Terraform Server Security Group"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
