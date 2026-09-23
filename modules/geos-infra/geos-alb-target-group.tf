resource "aws_lb_target_group" "geos_alb_target_group" {
  name        = "geos-alb-target-group"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.geos_vpc.id

  health_check {
    path     = "/"
    protocol = "HTTP"
  }
}

