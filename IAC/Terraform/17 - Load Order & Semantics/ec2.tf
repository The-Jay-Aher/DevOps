data "aws_ami" "name" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "myEC2" {
  ami           = data.aws_ami.name.id
  instance_type = "t2.micro"
}