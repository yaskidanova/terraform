variable "tags" {
  description = "common tags"
  type        = map(string)
  default = {
    "Name"        = "aws-homework-vpc"
    "Environment" = "dev"
  }
}
