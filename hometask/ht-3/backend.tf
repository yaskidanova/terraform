terraform {
  backend "s3" {
    bucket  = "aws-session-backend-aug-homework-bucket"
    key     = "homework/task3/terraform.tfstate" # path to terraform.tfstate file 
    region  = "us-east-1"
    encrypt = true
  }
}
