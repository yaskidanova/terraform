data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "aws-session-backend-aug-homework-bucket"
    key    = "homework/task4/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_acm_certificate" "issued" {
  domain      = "heyimiana.com"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}


data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.10.*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
