data "terraform_remote_state" "eip_details" {
  backend = "s3"

  config = {
    region = "ap-south-1"
    key    = "terraform.tfstate"
    bucket = "terraform-cross-project-backend"
  }
}