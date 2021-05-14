resource "aws_lb" "test-application-loadbalancer" {
  name               = var.application_loadbalancer_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.loadbalancer_security_groups   ## ["${var.security_groups[0]}", "${var.security_groups[1]}", "${var.security_groups[2]}"]
  subnets            = var.subnets ##  ["${var.subnets[0]}", "${var.subnets[1]}", "${var.subnets[2]}"]

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
  target_type = var.target_type_alb
  load_balancing_algorithm_type = var.load_balancing_algorithm_type
  stickiness {
  type = var.stickiness_type ## The type of sticky sessions. The only current possible values are lb_cookie for ALBs and source_ip for NLBs.
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

##Application Loadbalancer listener for HTTP
resource "aws_lb_listener" "alb_listener_front_end_HTTP" {
  load_balancer_arn = aws_lb.test-application-loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = var.http_type
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
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.https_type
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}



resource "aws_launch_configuration" "demo_launch_configuration" {
  name          = var.launch_configuration_name 
  image_id      = var.launch_configuration_image_id
  instance_type = var.instance_type
  iam_instance_profile = var.iam_instance_profile
  enable_monitoring = var.enable_monitoring
  ebs_optimized = var.ebs_optimized
  key_name = var.key_name
  security_groups = var.security_groups
  associate_public_ip_address = var.associate_public_ip_address
  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y httpd
                sudo systemctl start httpd
                sudo systemctl enable httpd
                echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
                EOF
  placement_tenancy = var.placement_tenancy
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "demo_autoscaling_group" {
  name                 = "demo-autostacling-group"
  launch_configuration = aws_launch_configuration.demo_launch_configuration.name
  min_size = var.min_size
  max_size = 3
  desired_capacity = 1
  availability_zones = ["us-east-2a", "us-east-2b", "us-east-2c"]
  default_cooldown = var.default_cooldown                   ##Time between a scaling activity and the succeeding scaling activity.
#  initial_lifecycle_hook = 
#  max_instance_lifetime = 
  service_linked_role_arn = var.service_linked_role_arn
  health_check_grace_period = 100          ## Time (in seconds) after instance comes into service before checking health.
  health_check_type = var.health_check_type[1]
  force_delete = true 
#  load_balancers =     ##Only valid for classic load balancers. For ALBs, use target_group_arns instead.
  target_group_arns = [aws_lb_target_group.target_group.arn]
  termination_policies = ["OldestInstance"]
  tag {
        key = "Environment" 
        value = "Dev"
        propagate_at_launch = true
  }
  depends_on = [ aws_launch_configuration.demo_launch_configuration, aws_lb_target_group.target_group ]  
}

resource "aws_autoscaling_policy" "scaleup_policy" {
  name                   = "scaleup-policy"
  autoscaling_group_name = aws_autoscaling_group.demo_autoscaling_group.name
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "SimpleScaling"
  scaling_adjustment     = 1     ### Used for Simple Scaling
  cooldown               = 100 #The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start

#  step_adjustment {             ### Used for step scaling
#    scaling_adjustment          = 1
#    metric_interval_lower_bound = 1.0
#    metric_interval_upper_bound = 2.0
#  }
#  estimated_instance_warmup = 100   ## Used for Step Scaling. The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start.
 
   depends_on = [ aws_autoscaling_group.demo_autoscaling_group ]
}
resource "aws_autoscaling_policy" "scaledown_policy" {
  name                   = "scaledown-policy"
  autoscaling_group_name = aws_autoscaling_group.demo_autoscaling_group.name
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "SimpleScaling"
  scaling_adjustment     = -1    ### Used for Simple Scaling
  cooldown               = 100 #The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start

#  step_adjustment {             ### Used for step scaling
#    scaling_adjustment          = -1
#    metric_interval_lower_bound = 1.0
#    metric_interval_upper_bound = 2.0
#  }
#  estimated_instance_warmup = 100   ##  Used for step scaling. The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start.

  depends_on = [ aws_autoscaling_group.demo_autoscaling_group ]
}

resource "aws_cloudwatch_metric_alarm" "cpuutilization-high" {
    alarm_name = "CPU-Utilization-High"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "1"
    datapoints_to_alarm = "1"
    treat_missing_data = var.treat_missing_data
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "300"
    statistic = "Average"
##  threshold_metric_id =    ### If this is an alarm based on an anomaly detection model, make this value match the ID of the ANOMALY_DETECTION_BAND function
    threshold = "65"
    alarm_description = "This metric monitors ec2 cpu-utilization for high utilization on agent hosts"
    alarm_actions = ["${aws_autoscaling_policy.scaleup_policy.arn}", "arn:aws:sns:us-east-2:562086155953:Test-Topic"]
    dimensions = { 
        AutoScalingGroupName = "${aws_autoscaling_group.demo_autoscaling_group.name}"
    }
    depends_on = [ aws_autoscaling_policy.scaleup_policy ]
}

resource "aws_cloudwatch_metric_alarm" "cpuutilization-low" {
    alarm_name = "CPU-Utilization-Low"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "1"
    datapoints_to_alarm = "1"
    treat_missing_data = var.treat_missing_data
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "300"
    statistic = "Average"
##  threshold_metric_id =    ### If this is an alarm based on an anomaly detection model, make this value match the ID of the ANOMALY_DETECTION_BAND function
    threshold = "40"
    alarm_description = "This metric monitors ec2 cpu-utilization for low utilization on agent hosts"
    alarm_actions = ["${aws_autoscaling_policy.scaledown_policy.arn}", "arn:aws:sns:us-east-2:562086155953:Test-Topic"]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.demo_autoscaling_group.name}"
    }
    depends_on = [ aws_autoscaling_policy.scaleup_policy ]
}
