variable "org" {
  type        = string
  description = "Organization"
  default     = "netflix"
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
  default     = "uw2"
}

variable "tier" {
  type        = string
  description = "Tier"
  default     = "frontend"
}
