data "terraform_remote_state" "alb" {
  backend = "s3"

  config = {
    bucket = "aws-session-backend-aug-homework-bucket"
    key    = "homework/task5/terraform.tfstate"
    region = "us-east-1"
  }
}


data "aws_route53_zone" "existing_zone" {
  name         = "heyimiana.com"
  private_zone = false
}
