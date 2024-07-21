terraform {
  required_providers {
    aws = {
      version = "~> 5.0"
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "Terraform_Security_Group" {
  name = "allow_tls"
  description = "Allow tls inbound traffic and all outbound traffic"
  
  tags = {
    Name = "Allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.Terraform_Security_Group.id
  from_port = 80
  to_port = 100
  ip_protocol = "tcp"
  cidr_ipv4 = "0.0.0.0/0" 
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.Terraform_Security_Group.id
  from_port = 0
  to_port = 0
  ip_protocol = "-1" # Semantically equal to all ports
  cidr_ipv4 = "0.0.0.0/0"
}