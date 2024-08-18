module "consul" {
  source        = "./module/ec2"
  instance_type = "t2.micro"
  region        = "ap-south-1"
  ami           = "ami-068e0f1a600cd311"
}