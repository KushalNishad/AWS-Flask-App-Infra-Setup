resource "aws_lb" "dev_flask_lb" {
  name               = var.lb_name
  internal           = var.is_external
  load_balancer_type = var.lb_type
  security_groups    = var.sg_enable_ssh_https
  subnets            = var.subnet_ids # Replace with your subnet IDs

  enable_deletion_protection = false

  tags = {
    Name = "kushalnishad-lb"
  }
}

resource "aws_lb_target_group_attachment" "dev_flask_lb_target_group_attachment" {
  target_group_arn = var.lb_target_group_arn
  target_id        = var.ec2_instance_id # Replace with your EC2 instance reference
  port             = var.lb_target_group_attachment_port
}

resource "aws_lb_listener" "dev_flask_lb_listner" {
  load_balancer_arn = aws_lb.dev_flask_lb.arn
  port              = var.lb_listner_port
  protocol          = var.lb_listner_protocol

  default_action {
    type             = var.lb_listner_default_action
    target_group_arn = var.lb_target_group_arn
  }
}

# https listner on port 443
resource "aws_lb_listener" "dev_flask_lb_https_listner" {
  load_balancer_arn = aws_lb.dev_flask_lb.arn
  port              = var.lb_https_listner_port
  protocol          = var.lb_https_listner_protocol
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.lb_listner_default_action
    target_group_arn = var.lb_target_group_arn
  }
}

resource "aws_lb_listener_certificate" "dev_flask_listener_cert" {
  listener_arn    = aws_lb_listener.dev_flask_lb_https_listner.arn
  certificate_arn = var.certificate_arn
}