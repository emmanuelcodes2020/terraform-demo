
resource "aws_acm_certificate" "major_application_acm_certificate" {
domain_name = "major-app-dev.lamtech.io"
validation_method = "DNS"
# lifecycle {
#   create_before_destroy = true
# }

}


resource "aws_acm_certificate_validation" "major_acm_certificate_validation" {
  certificate_arn = aws_acm_certificate.major_application_acm_certificate.arn
  validation_record_fqdns = [ aws_route53_record.major_route53_record.fqdn ]
  
}

resource "aws_route53_record" "cert_validation" {
  zone_id = data.aws_route53_zone.selected.zone_id
  allow_overwrite = true
  name = element(aws_acm_certificate.major_application_acm_certificate.domain_validation_options.*.resource_record_name, 0)
  type = element(aws_acm_certificate.major_application_acm_certificate.domain_validation_options.*.resource_record_type, 0)
  records = [ element(aws_acm_certificate.major_application_acm_certificate.domain_validation_options.*.resource_record_value, 0)]
  ttl = 60
}


