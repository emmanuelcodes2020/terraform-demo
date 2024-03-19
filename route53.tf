resource "aws_route53_record" "major_route53_record" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name = "major-app-dev.lamtech.io"
  type = "A"
  alias {
    name = aws_lb.major_app_lb.dns_name
    zone_id = aws_lb.major_app_lb.zone_id
    evaluate_target_health = true
  }
  
}




