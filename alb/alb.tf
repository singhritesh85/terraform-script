#Application Loadbalancer
resource "aws_lb" "test-application-loadbalancer" {
  name               = var.application_loadbalancer_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = ["${var.security_groups[0]}", "${var.security_groups[1]}", "${var.security_groups[2]}"]
  subnets            = ["${var.subnets[0]}", "${var.subnets[1]}", "${var.subnets[2]}"]

  enable_deletion_protection = var.enable_deletion_protection
  idle_timeout = var.idle_timeout
  access_logs {
    bucket  = var.access_log_bucket
    prefix  = var.prefix
    enabled = var.enabled
  }

  tags = {
    Environment = "Dev"
  }
}

#Target Group of Application Loadbalancer
resource "aws_lb_target_group" "target_group" {
  name     = var.target_group_name
  port     = var.instance_port      ##### Don't use protocol when target type is lambda
  protocol = var.instance_protocol  ##### Don't use protocol when target type is lambda
  vpc_id   = var.vpc_id
  target_type = var.target_type_alb[0]
  load_balancing_algorithm_type = var.load_balancing_algorithm_type[0]
  stickiness {
  type = var.stickiness_type[0] ## The type of sticky sessions. The only current possible values are lb_cookie for ALBs and source_ip for NLBs.
  cookie_duration = var.cookie_duration  ##Only used when the type is lb_cookie. The time period, in seconds, during which requests from a client should be routed to the same target. The range is 1 second to 1 week (604800 seconds). The default value is 1 day (86400 seconds).
  enabled = false  
  }
  health_check {
    enabled = true ## Indicates whether health checks are enabled. Defaults to true.
    path = "/index.html"
    port = "traffic-port"
    protocol = "HTTP"
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    interval            = var.interval
  }
}

##Application Loadbalancer listener for HTTPS
resource "aws_lb_listener" "alb_listener_front_end_HTTP" {
  load_balancer_arn = aws_lb.test-application-loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = var.type[1]
    target_group_arn = aws_lb_target_group.target_group.arn
     redirect {    ### Redirect HTTP to HTTPS
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

##Application Loadbalancer listener for HTTPS
resource "aws_lb_listener" "alb_listener_front_end_HTTPS" {
  load_balancer_arn = aws_lb.test-application-loadbalancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy[0]
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.type[0]
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

## EC2 Instance1 attachment to Target Group
resource "aws_lb_target_group_attachment" "ec2_instance1_attachment_to_tg" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = "i-0a3487c208f3ef9d8"
  port             = 80
}

## EC2 Instance2 attachment to Target Group
resource "aws_lb_target_group_attachment" "ec2_instance2_attachment_to_tg" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = "i-0d8376af2428cf5f5"
  port             = 80
}
