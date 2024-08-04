provider "aws" {
  region = "ap-south-1"
}

resource "aws_iam_user" "this" {
  name = "demo-user"
}

resource "aws_iam_user_policy" "this_policy" {
  name = "demo-user-policy"
  user = aws_iam_user.this.name

  # policy = jsonencode()
  policy = file("./iam-user-policy.txt")
}

