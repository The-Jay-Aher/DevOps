variable "password" {
  default   = "super-secret-password"
  sensitive = true
}

resource "local_file" "foo" {
  content  = var.password
  filename = "ar2.txt"
}

resource "local_sensitive_file" "goes" {
  content  = "super-nuclear-password"
  filename = "ar1.txt"
}

output "val" {
  value     = local_file.foo.content
  sensitive = true
}
