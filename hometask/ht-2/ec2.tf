resource "aws_instance" "first_ec2" {
  ami           = "ami-00a8151272c45cd8e"
  instance_type = "t2.micro"

  user_data = file("script.sh")

  tags = {
    Name = "my-terraform-webserver"
  }
}
