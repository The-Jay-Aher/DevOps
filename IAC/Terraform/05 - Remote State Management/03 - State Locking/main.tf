resource "time_sleep" "wait_120_sec" {
  create_duration  = "120s"
  destroy_duration = "60s"
}

terraform {
  backend "s3" {
    bucket         = "terraform-backend-practical"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-locking"
  }
}