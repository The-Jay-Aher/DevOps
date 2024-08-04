variable "types" {
  type = map(any)
  default = {
    us-east-1  = "t2.micro"
    us-west-2  = "t2.nano"
    ap-south-1 = "t2.small"
  }
}

variable "list" {
  type    = list(any)
  default = ["m5.large", "m5.xlarge", "t2.medium"]
}

resource "aws_instance" "myEC2" {
  ami           = "ami-068e0f1a600cd311c"
  instance_type = var.list[2]
  # instance_type = var.types["us-west-2"]
}