terraform {
  backend "s3" {
    bucket  = "aws-session-terraform-backend-bucket-aug-iana"
    key     = "project-14/dev/terraform.tfstate" # path to terraform.tfstate file 
    region  = "us-west-2"
    encrypt = true
  }
}
