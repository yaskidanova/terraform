resource "aws_instance" "main" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = var.tags
}


#  secind label must be unique 
# AS LONG AS THESE ARE DIFFERENT REDOURCES (first label) YOU CAN USE SAME NAME 

# reference to resource - reference to an attribute of the resource that already exist 

# by default terraform has implicit dependency

# reference to input variable
# var.variable_name

# resource type / block is to create and manage resources 
# data source type/block is to fetch the data from existing resources

# How to reference to a Data Source? data.first_label.second_label.attribute
