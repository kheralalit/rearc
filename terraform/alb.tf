# alb.tf

resource "aws_alb" "main" {
  name            = "quest-lb"
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.lb.id]
}

resource "aws_alb_target_group" "app" {
  name        = "cb-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "instance"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port              = 80
  protocol          = "HTTP"
  #ssl_policy = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
  #certificate_arn = "arn:aws:acm:ap-south-1:624547490816:certificate/dfc04f0a-2d1e-41e6-80ce-c02bf87d2d07"

  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}
