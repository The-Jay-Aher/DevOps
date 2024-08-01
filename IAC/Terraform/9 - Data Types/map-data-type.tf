variable "my-map" {
  type = map
  default = {
    us-east-1 = "t2.micro"
    us-west-1 = "t2.nano"
    ap-south-1 = "t2.small"
  }
}

output "variable_value" {
  value = var.my-map
}


resource "aws_instance" "myEC2" {
  ami = "ami-068e0f1a600cd311c"
  instance_type = var.my-map["ap-south-1"]
}
