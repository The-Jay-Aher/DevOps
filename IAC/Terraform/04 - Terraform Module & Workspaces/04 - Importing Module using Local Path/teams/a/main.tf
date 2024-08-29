module "consul" {
  source        = "../../module/ec2"
  instance_type = "t2.micro"
  ami           = "ami-068e0f1a600cd311"
}

resource "aws_eip" "IpAddress" {
  domain   = "vpc"
  instance = module.consul.instance_id
}
