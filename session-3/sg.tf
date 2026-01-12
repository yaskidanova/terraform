resource "aws_security_group" "main" {
  name        = "aws-session-sg"
  description = "This is a security group for an ec2 instance"

  tags = {
    Name = "aws-session-sg"
  }
}
