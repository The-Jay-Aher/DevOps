provider "aws" {
  region = "ap-south-1"
}

resource "aws_iam_user" "lb" {
  name  = "IAMuser.${count.index}"
  count = 3
  path  = "/system/"
}
/* Not needed
output "arns" {
  value = aws_iam_user.lb[*].arn
}

output "name" {
  value = aws_iam_user.lb[*].name
}
*/
output "combined" {
  value = zipmap(aws_iam_user.lb[*].name, aws_iam_user.lb[*].arn)
}