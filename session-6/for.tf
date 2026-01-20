resource "aws_sqs_queue" "main" {
  for_each = toset(var.names) //map or set of strings
  name     = each.key

}

variable "names" {
  type        = list(string)
  description = "This variable is sqs queue names"
  default     = ["queue-1", "queue-2", "queue-3"]
}


// list of strings vs set of strings (tuple)

resource "aws_sqs_queue" "new" {
  for_each = toset(local.names)
  name     = each.key
}

// for = transform value only 

locals {
  names = [for a in range(1, 3) : "new-queue-${a}"]
}


resource "aws_security_group" "main" {
  name        = "aws-session-sg"
  description = "This is a security group for an ec2 instance"

}

resource "aws_security_group_rule" "main" {
  for_each          = local.service
  type              = "ingress"
  from_port         = each.value.port
  to_port           = each.value.port
  protocol          = "tcp"
  cidr_blocks       = [each.value.cidr_blocks]
  security_group_id = aws_security_group.main.id
}

variable "services" {
  default = [
    { name = "ssh", port = 22, cidr_blocks = "10.0.0.0/16" },
    { name = "web", port = 80, cidr_blocks = "0.0.0.0/0" }
  ]
}

locals {
  service = {
    for svc in var.services : svc.name => { port = svc.port, cidr_blocks = svc.cidr_blocks }
  }
}

# local.service
# ssh = {
#     port = 22
#     cidr_blocks = "10.0.0.0/16"
# }

locals {
  service_ports = {
    for svc in var.services : svc.name => svc.port
  }

  service_cidr_blocks = {
    for svc in var.services : svc.name => svc.cidr_blocks
  }
}

# local.service_ports {
#   ssh = 22
#   web = 80
# }






// S : vallue - list of maps
// T: transform a value to a map or a set of string 
// A: for 
// R: pass a transformed value to security group 
