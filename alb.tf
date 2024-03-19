# Application Load balance

resource "aws_lb" "major_app_lb" {
    name = "major-application-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [ aws_security_group.major_application_lb_sg.id ]
    subnets = var.subnet_ranges

}



resource "aws_alb_target_group" "major_alb_tg" {
  name = "major-alb-tg"
  target_type = "instance"
  protocol = "HTTP"
  port = 80
  vpc_id = var.vpc_id
  health_check {
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
    interval = 30
    port = 80
    path = "/"
    

  }



}

# resource "aws_lb_listener" "major_lb_listener" {
#   load_balancer_arn = aws_lb.major_app_lb.arn
#   protocol = "HTTP"
#   port = 80
#   default_action {
#     type = "forward"
#     target_group_arn = aws_alb_target_group.major_alb_tg.arn
#   }
  
# }




resource "aws_lb_listener" "major_lb_listener" {
  load_balancer_arn = aws_lb.major_app_lb.arn
  protocol = "HTTPS"
  port = 443
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.major_alb_tg.arn
  }
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.major_application_acm_certificate.arn
}







resource "aws_alb_target_group_attachment" "major_alb_tg_attach" {
target_group_arn =  aws_alb_target_group.major_alb_tg.arn
target_id = aws_instance.major-app.id
port = 80
}