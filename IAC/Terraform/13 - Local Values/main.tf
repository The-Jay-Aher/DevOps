terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.60.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

variable "tags" {
  type = map(string)
  default = {
    "Team" = "Security-Team"
  }
}

locals {
  default = {
    Team         = "security-team"
    CreationDate = "date-${formatdate("DD=MM-YYYY", timestamp())}"
  }
}

resource "aws_security_group" "sg_01" {
  name = "app_firewall"
  tags = local.default
}

resource "aws_security_group" "sg_02" {
  name = "db_firewall"
  tags = local.default
}
