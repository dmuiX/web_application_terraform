resource "aws_security_group" "web-app-sg-instances" {
  name = var.web_app_sg_instances
}

resource "aws_security_group" "web-app-sg-alb" {
  name = var.web_app_sg_alb
}

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnets" "default_subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.web-app-sg-instances.id
  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web-app-alb.arn
  port              = 80
  protocol          = "HTTP"
  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

//target group where the load balancer will forward traffic
resource "aws_lb_target_group" "web-app-instances" {
  name     = var.web_app_target_group
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default_vpc.id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "web-app-instance_1" {
  target_group_arn = aws_lb_target_group.web-app-instances.arn
  target_id        = aws_instance.web-app-instance_1.id
  port             = 8080
}

resource "aws_lb_target_group_attachment" "web-app-instance_2" {
  target_group_arn = aws_lb_target_group.web-app-instances.arn
  target_id        = aws_instance.web-app-instance_2.id
  port             = 8080
}

resource "aws_lb_listener_rule" "web-app-instances" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100
  condition {
    path_pattern {
      values = ["*"]
    }
  }
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-app-instances.arn
  }
}

resource "aws_security_group_rule" "allow_alb_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.web-app-sg-alb.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_alb_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.web-app-sg-alb.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_lb" "web-app-alb" {
  name               = var.web_app_alb
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default_subnet.ids
  security_groups    = [aws_security_group.web-app-sg-alb.id]
}