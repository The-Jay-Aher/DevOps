provider "aws" {
  region = "ap-south-1"
}

data "aws_ami" "myImage" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

/*
# Normal code
resource "aws_instance" "myEC2" {
  instance_type = "t2.micro"
  ami = data.aws_ami.myImage.id
   tags = {
     Name = "Terraform Instance"
   }
}
*/

# This will create first then destroy
resource "aws_instance" "myEC2" {
  ami           = data.aws_ami.myImage.id
  instance_type = "t2.micro"

  tags = {
    Name = "Hello-World"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# This will prevent destroy of any object
resource "aws_instance" "myEC2" {
  ami           = data.aws_ami.myImage.id
  instance_type = "t2.micro"

  tags = {
    Name = "Hello-World"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# This will ignore any changes made to the tags
resource "aws_instance" "myEC2" {
  ami           = data.aws_ami.myImage.id
  instance_type = "t2.micro"

  tags = {
    Name = "Hello-World"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

