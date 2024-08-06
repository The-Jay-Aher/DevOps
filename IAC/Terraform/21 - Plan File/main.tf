resource "local_file" "foo" {
  content  = "New Content"
  filename = "terraform2.txt"
}