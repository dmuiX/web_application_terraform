resource "aws_route53_zone" "web-app-primary" {
  name = var.web_app_domain
}

resource "aws_route53_record" "web-app-root" {
  zone_id = aws_route53_zone.web-app-primary.zone_id
  name    = var.web_app_domain
  type    = "A"
  alias {
    name                   = aws_lb.web-app-alb.dns_name
    zone_id                = aws_lb.web-app-alb.zone_id
    evaluate_target_health = true
  }
}