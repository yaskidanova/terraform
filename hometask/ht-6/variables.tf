variable "org" {
  type        = string
  description = "Organization"
  default     = "project"
}

variable "dep" {
  type        = string
  description = "Department"
  default     = "it"
}

variable "bu" {
  type        = string
  description = "Business Unit"
  default     = "ai"
}

variable "env" {
  type        = string
  description = "Environment"
  default     = "dev"
}

variable "region" {
  type        = string
  description = "Provider region"
  default     = "us1"
}

variable "tier" {
  type        = string
  description = "Tier"
  default     = "frontend"
}


variable "ingress_ports_alb" {
  type        = list(number)
  description = "A list of ingress ports for alb"
  default     = [80, 443]
}

variable "instance_type" {
  type        = string
  description = "ec2 instance type"
  default     = "t2.micro"
}

variable "ingress_ports_ec2" {
  type        = number
  description = "Ingress port for ec2 instance"
  default     = 80
}
