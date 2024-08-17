resource "aws_instance" "myEC2" {
  ami                    = "ami-0ae8f15ae66fe8cda"
  instance_type          = "t2.micro"
  key_name               = "terraform-key"
  vpc_security_group_ids = ["sg-0484a88acfe5f265b"]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./terraform-key.pem")
    host        = self.public_ip
    # private_key = "terraform-key.pem" # Wrong way of declaration
    # password = "" # Not enabled for aws image
  }

  provisioner "local-exec" {
    command = "echo Public IP = ${self.public_ip} >> server_ip.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install nginx",
      "sudo systemctl start nginx",
    ]
  }

}


