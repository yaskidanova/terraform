

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.existing_zone.zone_id
  name    = "hw.heyimiana.com"
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.alb.outputs.lb_dns_name
    zone_id                = data.terraform_remote_state.alb.outputs.lb_zone_id
    evaluate_target_health = true
  }
}
