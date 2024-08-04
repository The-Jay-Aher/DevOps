# Local Operations

# data "local_file" "foo" {
#   filename = "${path.module}/demo.txt"
# }

# output "data" {
#   value = data.local_file.foo.content
# }

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "myEC2" {
  instance_type = "t2.micro"
  ami           = "ami-068e0f1a600cd311c"
  count         = 2

  tags = {
    Name = "Terraform-Server-${count.index + 1}"
  }
}

# There is a difference in Instance(single) and Instances(multiple)
data "aws_instance" "random" {
  filter {
    name   = "tag:Team"
    values = ["Production"]
  }
}