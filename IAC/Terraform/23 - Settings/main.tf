terraform {
  required_version = "1.8" # The code wont work until the version 1.8 of terraform is installed
  required_providers {
    aws = {
      required_version = ">= 4.0"
      source           = "hashicorp/aws"
    }
  }
}

resource "aws_security_group" "sg_01" {
  name = "app_firewall"
}