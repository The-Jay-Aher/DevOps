terraform {
  backend "s3" {
    region = "ap-south-1"
    key    = "terraform.tfstate"
    bucket = "terraform-cross-project-backend"
  }
}

# This is for storing the state file remotely on s3 bucket