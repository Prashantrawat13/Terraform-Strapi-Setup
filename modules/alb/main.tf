######### External Load Balancer, Listner Group  and Launch template for Web tier#########


resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc-id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "web-tg"
  }
  
}



resource "aws_lb" "web_alb" {
  name               = "external-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.external-lb-sg]
  subnets            = var.public_subnet

  tags = {
    Name        = "external-web-alb"
  }
}


resource "aws_lb_listener" "web_alb_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}







######### Load Balancer, listner group and Launch template for Web tier#########



resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc-id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "app-tg"
  }
  
}



resource "aws_lb" "app_alb" {
  name               = "Internal-app-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.internal-lb-sg]
  subnets            = var.private_subnet

  tags = {
    Name        = "Internal-app-alb"
  }
}


resource "aws_lb_listener" "app_alb_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
    }
}