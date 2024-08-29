# Code for creating a S3 bucket
provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-cross-project-backend"

  tags = {
    Name        = "My Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.bucket
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "bucket_block_public_access" {
  bucket                  = aws_s3_bucket.bucket.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}