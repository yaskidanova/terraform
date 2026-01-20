// create 2 S3 bucket with the same resource block 
// names: terraform-session-aug-yourname1; terraform-session-aug-yourname2
// object_lock_enabled = false , object_lock_enabled = true 
// acl = private, public_read
// tag: name = bucket-1, bucket-2

resource "aws_s3_bucket" "main" {
  for_each            = var.buckets
  bucket              = each.value.name
  object_lock_enabled = each.value.object_lock_enabled

  tags = {
    Name = each.key
  }
}
// input variables to configure resources
variable "buckets" {
  description = "This is a map for buckets"
  type        = map(any) //map pf strings, bool, number
  default = {
    bucket-1 = {
      name                = "terraform-session-aug2025-iana-1",
      object_lock_enabled = true,

    }
    bucket-2 = {
      name                = "terraform-session-aug2025-iana-2",
      object_lock_enabled = false,

    }
  }
}

// count = main[0]

// for_each = aws_s3_bucket.main["bucket-1"]
