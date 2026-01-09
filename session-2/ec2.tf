resource "aws_instance" "first_ec2" {
  ami           = "ami-00a8151272c45cd8e"
  instance_type = "t2.micro"

  tags = {
    Name        = "first"
    Environment = "dev"
  }
}

# resourse = block , used to create and manage resources 
# "aws_instance" = first label, indicate the resource that you want to create and manage, defined by terraform 
# "first_ec2" = second label, logical id or logical name of the resource, defined by me (Must be unique within working directory)

# argument = key value, configuration of the resource, key is defined by terraform , value is given by us 

# data types:
# "" string
#  {} map

