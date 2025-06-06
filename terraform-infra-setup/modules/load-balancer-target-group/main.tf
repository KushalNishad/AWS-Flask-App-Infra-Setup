resource "aws_lb_target_group" "dev_flask_lb_target_group" {
  name     = var.lb_target_group_name
  port     = var.lb_target_group_port
  protocol = var.lb_target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    port                = 5000
    healthy_threshold   = 6
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200" # has to be HTTP 200 or fails
  }

}

resource "aws_lb_target_group_attachment" "dev_flask_lb_target_group_attachment" {
  target_group_arn = aws_lb_target_group.dev_flask_lb_target_group.arn
  target_id        = var.ec2_instance_id
  port             = 5000
}