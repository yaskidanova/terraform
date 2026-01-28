resource "aws_sqs_queue" "main" {
  name = "${var.env}-queue"

}

variable "env" {
  type        = string
  default     = "dev"
  description = "Environment"
}

resource "aws_instance" "first_ec2" {
  ami           = "ami-00a8151272c45cd8e"
  instance_type = "t2.micro"

  tags = {
    Name        = "first"
    Environment = "dev"
  }
}
