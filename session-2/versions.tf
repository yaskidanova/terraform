terraform {
  required_version = "~> 1.14.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.28.0"
    }
  }
}

# semantic versioning = 3.24.0-alpha1(beta)
# 3 = major version - upgrade
# 24 = minor version - update = features 
# 0 = patch version - patch = fix vulnerabilities 
# alpha1 = experements, never used in prod 
# beta1 = almost ready, but with some issues, usually for qa env

# ~> = lazy constraints 
# ~> 0.14.0 = cover up all versions started with 0.14.0 - 0.14.x
# ">= 0/14, <0.15"    =    0.14.x
