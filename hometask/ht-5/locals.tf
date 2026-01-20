locals {
  name = "${var.org}-${var.dep}-${var.bu}-${var.env}-${var.region}-${var.tier}-rtype"


  common_tags = {
    Environment   = var.env
    Business_unit = var.bu
    Tier          = var.tier
    Team          = "devops"
    Project_name  = "my-project"
    Managed_by    = "terraform"
    Owner         = "support@akumosolutions.io"
  }
}
