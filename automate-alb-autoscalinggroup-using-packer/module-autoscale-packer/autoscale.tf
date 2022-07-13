resource "aws_security_group" "allow_tls" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = var.cidr_blocks
  }
  
  ingress {
    protocol   = "tcp"
    cidr_blocks = var.cidr_blocks
    from_port  = 80
    to_port    = 80
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test-sg"
  }
}


resource "aws_lb" "application-loadbalancer" {
  name               = var.alb_name
  internal           = var.internal_external
  load_balancer_type = var.loadbalancer_type
  security_groups    = [aws_security_group.allow_tls.id]
  subnets            = var.subnets

  enable_deletion_protection = var.enable_deletion_protection

  access_logs {
    bucket  = var.bucket
    prefix  = var.prefix
    enabled = true
  }

  tags = {
    Environment = "production"
  }
  depends_on = [ aws_security_group.allow_tls ]
}


resource "aws_lb_target_group" "autoscale_alb_tg" {
  name        = var.alb_tg_name
  target_type = var.target_type
  port        = var.instance_port 
  protocol    = var.instance_protocol
  vpc_id      = var.vpc_id
  stickiness {
    cookie_duration = var.cookie_duration 
    enabled = false
    type = var.stickiness_type
  }
  health_check {
    enabled = true
    healthy_threshold = var.healthy_threshold
    interval = var.interval
    path = var.healthcheck_path
    port = "traffic-port"
    protocol = var.healthcheck_protocol
    timeout = var.timeout
    unhealthy_threshold = var.unhealthy_threshold 
  }
  depends_on = [ aws_lb.application-loadbalancer ]
}


resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.application-loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "redirect"
    target_group_arn = aws_lb_target_group.autoscale_alb_tg.arn
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

}


resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.application-loadbalancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.autoscale_alb_tg.arn
  }

}


resource "aws_launch_configuration" "asg_lc" {
  name   = var.launchconfiguration_name
  image_id      = var.AMI_ID
  instance_type = var.instance_type
  iam_instance_profile = var.iam_instance_profile
  key_name = var.key_name
  security_groups = var.security_groups
  associate_public_ip_address = var.associate_public_ip_address
  enable_monitoring = var.enable_monitoring
  ebs_optimized = var.ebs_optimized
  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    delete_on_termination = true
    encrypted = true
  }
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              service httpd start
              chkconfig httpd on
              echo "<h1>Deployed Via Terraform</h1>" >> /var/www/html/index.html
              EOF
  
  placement_tenancy = var.placement_tenancy

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "asg" {
  name                 = var.asg_name
  launch_configuration = aws_launch_configuration.asg_lc.name
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity  
  vpc_zone_identifier  = var.vpc_zone_identifier
  default_cooldown     = var.default_cooldown  # The amount of time, in seconds, after a scaling activity completes before another scaling activity can start.
  service_linked_role_arn = var.service_linked_role_arn
  health_check_grace_period = var.health_check_grace_period   # Time (in seconds) after instance comes into service before checking health.
  health_check_type    = var.health_check_type
  force_delete         = var.force_delete # Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate.
  target_group_arns    = [aws_lb_target_group.autoscale_alb_tg.arn]
  termination_policies = ["OldestLaunchConfiguration"]
  tag {
          key                 = "Environment"
          value               = "Dev"
          propagate_at_launch = true
  }
  

  lifecycle {
    create_before_destroy = true
  }
  
  depends_on = [ aws_launch_configuration.asg_lc ]
}


resource "aws_autoscaling_policy" "scaleup" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  name                   = "scaleout"
  policy_type            = "StepScaling"
#  cooldown               = 100  # The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start, used for SimpleScaling.
  adjustment_type        = "ChangeInCapacity" 
  estimated_instance_warmup = 100  # The estimated time, in seconds, until a newly launched instance will contribute CloudWatch metrics. 

  step_adjustment {
    scaling_adjustment          = 1
    metric_interval_lower_bound = 0
    metric_interval_upper_bound = ""   # Without a value, AWS will treat this bound as infinity.
  }
  
  depends_on = [ aws_launch_configuration.asg_lc, aws_autoscaling_group.asg ]

}


resource "aws_autoscaling_policy" "scaledown" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  name                   = "scalein"
  policy_type            = "StepScaling"
#  cooldown               = 100  # The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start, used for SimpleScaling.
  adjustment_type        = "ChangeInCapacity"
  estimated_instance_warmup = 100  # The estimated time, in seconds, until a newly launched instance will contribute CloudWatch metrics.

  step_adjustment {
    scaling_adjustment          = -1
    metric_interval_lower_bound = "" # Without a value, AWS will treat this bound as infinity.
    metric_interval_upper_bound = 0  # Without a value, AWS will treat this bound as infinity.
  }
  
  depends_on = [ aws_launch_configuration.asg_lc, aws_autoscaling_group.asg ]

}


resource "aws_cloudwatch_metric_alarm" "cloudwatchalarm_high" {
  alarm_name          = "CloudwatchAlarm-High"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  datapoints_to_alarm = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "50"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }

  alarm_description = "This metric monitors autoscaling ec2 scaleup cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.scaleup.arn, "arn:aws:sns:us-east-2:694148179922:MyTopic"]
  depends_on = [ aws_autoscaling_policy.scaleup ]
}


resource "aws_cloudwatch_metric_alarm" "cloudwatchalarm_low" {
  alarm_name          = "CloudwatchAlarm-Low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  datapoints_to_alarm = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "50"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }

  alarm_description = "This metric monitors autoscaling ec2 scaledown cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.scaledown.arn, "arn:aws:sns:us-east-2:694148179922:MyTopic"]
  depends_on = [ aws_autoscaling_policy.scaledown ]
}
