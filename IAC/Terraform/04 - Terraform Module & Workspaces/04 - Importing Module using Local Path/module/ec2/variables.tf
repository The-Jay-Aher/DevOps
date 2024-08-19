
variable "ami" {
  default     = "ami-068e0f1a600cd311"
  description = "This is the AMI from ap-south-1"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Default instance_type, we can also use a if condition to declare the instance_type"
}

/*
variable "region" {
  default = "us-east-1"
}
*/

/*
variable "ami" {

}


variable "instance_type" {

}
*/