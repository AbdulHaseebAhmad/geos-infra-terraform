resource "aws_lb_target_group_attachment" "geos_app_servers" {
  count = length(aws_instance.geos_app_servers)

  target_group_arn = aws_lb_target_group.geos_alb_target_group.arn
  target_id        = aws_instance.geos_app_servers[count.index].id
  port             = 80
}