resource "aws_security_group" "main" {
  name        = "aws-session-sg"
  description = "This is a security group for an ec2 instance"

  tags = merge(
    var.tags,
    { "Name" = "${var.env}-security-group" }, # most popular way 
    { "Name1" = format("%s-security-group", var.env) }
  )
}

resource "aws_security_group_rule" "main" {
  count             = length(var.ports)
  type              = "ingress"
  from_port         = element(var.ports, count.index)
  to_port           = var.ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_blocks[count.index]]
  security_group_id = aws_security_group.main.id
}

resource "aws_security_group_rule" "main_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1" #tcp, udp, icmp
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main.id
}
