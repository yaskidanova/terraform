terraform {
  backend "s3" {
    bucket         = "aws-session-terraform-backend-bucket-aug-iana"
    key            = "session-9/terraform.tfstate" # path to terraform.tfstate file 
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-session-aug25-lock"
  }
}
