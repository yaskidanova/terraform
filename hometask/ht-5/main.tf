# for alb:
# security group 
# application load balancer
# target group 
# listener
# http -> https redirect


/// Security group for ALB ///

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  tags = merge(
    local.common_tags,
    { Name = replace(local.name, "rtype", "alb_sg") }
  )
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  count             = length(var.ingress_ports_alb)
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = var.ingress_ports_alb[count.index]
  ip_protocol       = "tcp"
  to_port           = var.ingress_ports_alb[count.index]
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}



/// Application load balancer ///

resource "aws_lb" "alb" {
  name               = "homework-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  tags = merge(
    local.common_tags,
    { Name = replace(local.name, "rtype", "alb") }
  )
}

/// Target group for ALB ///

resource "aws_lb_target_group" "alb_ec2_tg" {
  name     = "alb-tg"
  port     = var.ingress_ports_alb[0]
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id
  tags = merge(
    local.common_tags,
    { Name = replace(local.name, "rtype", "alb_ec2_tg") }
  )
}

/// Listener /// 

resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.ingress_ports_alb[0]
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
    target_group_arn = aws_lb_target_group.alb_ec2_tg.arn
  }

  tags = merge(
    local.common_tags,
    { Name = replace(local.name, "rtype", "alb_listener") }
  )
}

resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.ingress_ports_alb[1]
  protocol          = "HTTPS"
  certificate_arn   = data.aws_acm_certificate.issued.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_ec2_tg.arn
  }

  tags = merge(
    local.common_tags,
    { Name = replace(local.name, "rtype", "alb_listener") }
  )
}


# for asg:
# launch tamplate 
# sg for ec2
# asg

/// Launch Template ///

resource "aws_launch_template" "ec2_launch_template" {
  name          = "web-server"
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = data.terraform_remote_state.vpc.outputs.private_subnet_ids[0]
    security_groups             = [aws_security_group.ec2_lt_sg.id]
  }
  user_data = base64encode(file("user_data.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      local.common_tags,
      { Name = replace(local.name, "rtype", "ec2_web_server") }
    )
  }
}

/// Security group for EC2 ///

resource "aws_security_group" "ec2_lt_sg" {
  name        = "ec2-sg"
  description = "Security group for EC2 Instance"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  tags = merge(
    local.common_tags,
    { Name = replace(local.name, "rtype", "ec2_lt_sg") }
  )
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_from_alb" {
  security_group_id            = aws_security_group.ec2_lt_sg.id
  from_port                    = var.ingress_ports_ec2
  ip_protocol                  = "tcp"
  to_port                      = var.ingress_ports_ec2
  referenced_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.ec2_lt_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

/// Autoscaling group ///

resource "aws_autoscaling_group" "ec2_asg" {
  name = "ec2_asg"

  min_size         = 1
  max_size         = 3
  desired_capacity = 2

  target_group_arns   = [aws_lb_target_group.alb_ec2_tg.arn]
  vpc_zone_identifier = data.terraform_remote_state.vpc.outputs.private_subnet_ids

  launch_template {
    id      = aws_launch_template.ec2_launch_template.id
    version = "$Latest"
  }
  health_check_type = "EC2"


}
