provider "aws" {
  region = "ap-south-1"
}

provider "aws" {
  alias  = "singapore"
  region = "ap-southeast-1"
}

provider "aws" {
  alias  = "usa"
  region = "us-east-1"
}

resource "aws_security_group" "sg_1" {
  name     = "Security-Group-1"
  provider = aws.singapore
}

resource "aws_security_group" "sg_2" {
  name = "Security-Group-2"
}

resource "aws_security_group" "sg_3" {
  name     = "Security-Group-3"
  provider = aws.usa
}
