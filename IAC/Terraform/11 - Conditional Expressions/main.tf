provider "aws" {
  region = "ap-south-1"
}

variable "environment" {
  # default = "development"
}

variable "region" {
  default = "ap-south-1"
}

variable "names" {
  type = list(string)
  default = [ "alpha", "beta", "gamma" ]
}

# Single Condition
resource "aws_instance" "example" {
  instance_type = var.environment == "" ? "t2.micro" : "t2.nano"
  ami = "ami-068e0f1a600cd311c"
  count = 3
  
  tags = {
    Name = "example-resource-${var.names[count.index]}"
  }
}


#Multiple Condition
resource "aws_instance" "this" {
  instance_type = var.environment == "production" && var.region == "us-east-1" ? "t2.micro" : "t2.nano"
  count = 2
  ami = "ami-068e0f1a600cd311c"
  
  tags = {
    Name = "Instance-${var.names[count.index]}"
  }
}