variable "instance_type" {
  description = "aws ec2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "tags" {
  description = "common tags"
  type        = map(string)
  default = {
    "Project"    = "aws-session"
    "Managed_by" = "terraform"
  }
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "ports" {
  description = "List of ports"
  type        = list(string)
  default     = ["22", "80", "443", "3306"]
}

variable "cidr_blocks" {
  description = "List of cidr blocks"
  type        = list(string)
  default     = ["0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0", "10.0.1.0/24"]
}
