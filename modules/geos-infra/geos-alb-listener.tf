resource "aws_lb_listener" "geos_alb_listener_https" {
  load_balancer_arn = aws_lb.geos_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate_validation.geos_cert_validation.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.geos_alb_target_group.arn
  }
}

resource "aws_lb_listener" "geos_alb_listener" {
  load_balancer_arn = aws_lb.geos_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}