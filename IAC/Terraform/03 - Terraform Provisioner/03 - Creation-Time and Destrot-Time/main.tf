resource "aws_iam_user" "lb" {
  name = "provisioner-user"

  provisioner "local-exec" {
    command = "echo This is creation time provisioner"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo This is destroy time provisioner"
  }

  # Failure Behavior
  provisioner "local-exec" {
    on_failure = fail
    command    = "echo This is a creation time provisioner"
  }
}