provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "sg" {
  name        = "Terraform-SG"
  description = "Whitelist the EIP"
  tags = {
    "Name" = "Terraform-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "whitelist_tls_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "${data.terraform_remote_state.eip_details.outputs.eip_addr}/32"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  from_port         = "0"
  to_port           = "0"
}