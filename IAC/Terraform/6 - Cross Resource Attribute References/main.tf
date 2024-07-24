terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_eip" "lb" {
  domain = "vpc"
}

resource "aws_security_group" "allow_tls" {
  name = "Attribute-SG"
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  
  cidr_ipv4 = "${aws_eip.lb.public_ip}/32"
  from_port = 443
  ip_protocol = "tls"
  to_port = 443
}