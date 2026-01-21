variable "env" {
  type        = string
  description = "Environment"
  default     = "dev"
}

variable "ami" {
  type        = string
  description = "Instance AMI"
}

variable "instance_type" {
  type        = string
  description = "ec2 instance type"
  default     = "t2.micro"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security group ids"
}
