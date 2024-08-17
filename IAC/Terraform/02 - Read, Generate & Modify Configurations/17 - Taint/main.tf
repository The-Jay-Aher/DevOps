data "aws_ami" "loop" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "myEC2" {
  ami           = data.aws_ami.loop.id
  instance_type = "t2.micro"

  tags = {
    "Name" = "terraform server"
  }
}

resource "aws_iam_user" "ln" {
  name  = "terraform-user-${count.index + 1}"
  count = 3
  path  = "/system/"
}

output "splat" {
  value = aws_iam_user.ln[*].arn
}