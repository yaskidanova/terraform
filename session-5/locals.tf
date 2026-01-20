# Naming standard / Convention 

# example: netflix-it—ai-dev-us-east-1-frontend-ec2

locals {
  // naming standard
  name = "${var.org}-${var.dep}-${var.bu}-${var.env}-${var.region}-${var.tier}-rtype"

  # using locals you can compute a new value 

  # Common tags

  common_tags = {
    Environment   = var.env
    Business_unit = var.bu
    Tier          = var.tier
    Team          = "devops"
    Project_name  = "streaming-ai"
    Managed_by    = "terraform"
    Owner         = "support@akumosolutions.io"
  }
}
