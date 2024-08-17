variable "sg_ports" {
  type        = list(number)
  description = "List of Ingress Ports"
  default     = [8200, 8201, 8300, 9200, 9500]
}

resource "aws_security_group" "dynamic-sg" {
  name        = "dynamic-security-group"
  description = "Ingress for vault"

  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}