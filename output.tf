output "aws_instance" {
  
  value = aws_instance.major-app.ami
}

output "aws_route53_record" {
value = aws_route53_record.major_route53_record.fqdn
}

output "aws_security_group" {
  value = aws_security_group.major_application_sg.vpc_id
}

output "aws_iam_instance_profile" {
  value = aws_iam_instance_profile.iam_profile.name
}

output "aws_lb" {
  value = aws_lb.major_app_lb.dns_name
  
}

output "aws_alb_target_group" {
  value = aws_alb_target_group.major_alb_tg.health_check
  
}

output "aws_route53_zone" {
  value = data.aws_route53_zone.selected.zone_id
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
  
}

