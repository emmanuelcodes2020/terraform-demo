locals {
  sg_name = "major_application"
}

resource "aws_security_group" "major_application_sg" {
  name        = "major-application-sg"
  description = "security group for HTTP"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${local.sg_name}-sg"

  }

}


resource "aws_security_group_rule" "ingress_https_access" {
  type              = "ingress"
  description       = "HTTPS access"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.major_application_sg.id


}


resource "aws_security_group_rule" "ingress_ssh_access" {
  type              = "ingress"
  description       = "SSH access"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.major_application_sg.id

}




resource "aws_security_group_rule" "ingress_http_access" {
  type              = "ingress"
  description       = "HTTP access"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.major_application_sg.id


}



resource "aws_security_group_rule" "egress_http_access" {
  type              = "egress"
  description       = "All traffic access to our VPC "
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.major_application_sg.id

}





# Security group for Application LB

resource "aws_security_group" "major_application_lb_sg" {
  name        = "major-application-lb-sg"
  description = "security group for HTTP"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${local.sg_name}-lb-sg"

  }

}



resource "aws_security_group_rule" "ingress_http_lb_access" {
  type              = "ingress"
  description       = "HTTP access"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.major_application_lb_sg.id


}

resource "aws_security_group_rule" "ingress_https_lb_access" {
  type              = "ingress"
  description       = "HTTPS access"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.major_application_lb_sg.id


}



resource "aws_security_group_rule" "egress_http_lb_access" {
  type              = "egress"
  description       = "All traffic access to our VPC "
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.major_application_lb_sg.id

}
