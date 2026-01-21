variable "name" {
  type        = string
  description = "Name of a security group"
  default     = "aws-session-sg"
}

variable "description" {
  type        = string
  description = "Security group descriprion"
  default     = "This is an aws-session-sg"
}
