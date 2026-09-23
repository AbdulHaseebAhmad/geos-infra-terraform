resource "aws_lb" "geos_alb" {
name = "${var.environment_name}-geos-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.geos_alb_sg.id]
  subnets            = [for subnet in aws_subnet.geos_public : subnet.id]

  tags = {
    Environment = var.environment_name
    Name        = "${var.environment_name}-geos-alb"
  }
}

