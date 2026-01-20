output "lb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.alb.dns_name
}

output "lb_zone_id" {
  description = "The zone id"
  value       = aws_lb.alb.zone_id
}
