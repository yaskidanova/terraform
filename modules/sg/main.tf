resource "aws_security_group" "main" {
  name        = var.name
  description = var.description
  tags = {
    Name = var.name
  }
}
