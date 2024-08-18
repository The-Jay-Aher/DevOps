provider "aws" {
  region = var.region
}

resource "aws_instance" "Terraform-Server" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "First-Terraform-Server"
  }
}
