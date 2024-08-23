provider "aws" {
  region = "ap-south-1"
}

locals {
  instance_type = {
    default = "t2.nano"
    dev     = "t2,micro"
    prod    = "m5.large"
  }
}

resource "aws_instance" "workspaceEC2" {
  ami           = "ami-068e0f1a600cd311c"
  instance_type = local.instance_type[terraform.workspace]

  tags = {
    Name = "${terraform.workspace == "dev" ? "Dev-Server" : "Prod-Server"} "
  }
}