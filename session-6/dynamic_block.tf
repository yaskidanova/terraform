resource "aws_security_group" "dynamic" {
  name        = "dynamic-sg"
  description = "This is a security group for an ec2 instance"

  dynamic "ingress" {
    for_each = var.inbound_rules
    iterator = ports

    content {
      from_port   = ports.value.port
      to_port     = ports.value.port
      protocol    = ports.value.protocol
      cidr_blocks = ports.value.cidr_blocks
    }
  }
  egress = [{
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
    description      = "All outbound"
  }]
}


variable "inbound_rules" {
  description = "this is a variable for inbound rules"
  type = list(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [{
    port        = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },

    {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
    },

  ]
}
