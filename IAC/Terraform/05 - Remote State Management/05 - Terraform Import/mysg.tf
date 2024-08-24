# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "sg-0d2491fefe29542b9"
resource "aws_security_group" "mySG" {
  description = "SG managed through Terraform"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow all Access"
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow HTTP from Internet"
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
    }, {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow HTTPS from Internet"
    from_port        = 443
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 443
    }, {
    cidr_blocks      = ["172.31.0.0/16"]
    description      = "Allow from Private Network"
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 22
  }]
  name                   = "Manual-Creation"
  name_prefix            = null
  revoke_rules_on_delete = null
  tags                   = {
    Name = "Terraform-SG"
  }
  tags_all               = {}
  vpc_id                 = "vpc-0e745197c4c462b3c"
}
