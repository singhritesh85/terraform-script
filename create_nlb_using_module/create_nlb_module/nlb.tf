# Network Loadbalancer
resource "aws_lb" "demo-network-loadbalancer" {
  name               = var.network_loadbalancer_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  subnets            = var.subnets                    # ["${var.subnets[0]}", "${var.subnets[1]}", "${var.subnets[2]}"]

  enable_deletion_protection = var.enable_deletion_protection
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing

  idle_timeout = var.idle_timeout
  access_logs {
    bucket  = var.access_log_bucket
    prefix  = var.prefix
    enabled = var.enabled
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Environment = "Dev"
  }
}

#Target Group of Network Loadbalancer
resource "aws_lb_target_group" "target_group" {
  name     = var.target_group_name
  port     = var.instance_port      ##### Don't use protocol when target type is lambda
  protocol = var.instance_protocol  ##### Don't use protocol when target type is lambda
  vpc_id   = var.vpc_id
  target_type = var.target_type_alb
  stickiness {
  type = var.stickiness_type ## The type of sticky sessions. The only current possible values are lb_cookie for ALBs and source_ip for NLBs.
  cookie_duration = var.cookie_duration  ##Only used when the type is lb_cookie. The time period, in seconds, during which requests from a client should be routed to the same target. The range is 1 second to 1 week (604800 seconds). The default value is 1 day (86400 seconds).
  enabled = false  
  }
  health_check {
    enabled = true ## Indicates whether health checks are enabled. Defaults to true.
    path = "/index.html"
    port = var.health_check_port
    protocol = var.health_check_protocol
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
#    timeout             = var.timeout    ## Timeout is not supported for target groups with TCP protocol
    interval            = var.interval
  }
}

## Network Loadbalancer listener for TCP
resource "aws_lb_listener" "nlb_listener_front_end_TCP" {
  load_balancer_arn = aws_lb.demo-network-loadbalancer.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = var.http_type
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

## Network Loadbalancer listener for TLS
resource "aws_lb_listener" "nlb_listener_front_end_TLS" {
  load_balancer_arn = aws_lb.demo-network-loadbalancer.arn
  port              = "443"
  protocol          = "TLS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.https_type
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

## EC2 Instance1 attachment to Target Group
resource "aws_lb_target_group_attachment" "ec2_instance1_attachment_to_tg" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.target_id_instance_1
  port             = 80
}

## EC2 Instance2 attachment to Target Group
resource "aws_lb_target_group_attachment" "ec2_instance2_attachment_to_tg" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.target_id_instance_2
  port             = 80
}
