provider "aws" {
  region = "ap-south-1"
}

import {
  to = aws_security_group.mySG
  id = "sg-0d2491fefe29542b9"
}
