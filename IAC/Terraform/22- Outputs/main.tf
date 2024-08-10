resource "aws_iam_user" "lb" {
  name  = "iam-user-${count.index}"
  count = 3
  path  = "/system/"
}

output "iam_names" {
  value = aws_iam_user.lb[*].name
}

output "iam_arn" {
  value = aws_iam_user.lb[*].arn
}