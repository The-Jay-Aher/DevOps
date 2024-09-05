terraform {
  backend "s3" {
    bucket = "terraform-backend-practical"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}