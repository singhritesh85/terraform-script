resource "aws_launch_configuration" "demo_launch_configuration" {
  name          = var.launch_configuration_name 
  image_id      = var.launch_configuration_image_id
  instance_type = var.instance_type[0]
  iam_instance_profile = var.iam_instance_profile
  enable_monitoring = var.enable_monitoring
  ebs_optimized = var.ebs_optimized[1]
  key_name = var.key_name[0]
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
  placement_tenancy = var.placement_tenancy[0]
  root_block_device {
    volume_type = var.volume_type[1]
    volume_size = var.volume_size
    iops = var.iops
    delete_on_termination = var.delete_on_termination[0]
    encrypted = var.encrypted[0]
  }
  ebs_block_device {
    device_name = var.device_name
    volume_type = var.volume_type[1]
    volume_size = var.volume_size
    iops = var.iops
    delete_on_termination = var.delete_on_termination[0]
    encrypted = var.encrypted[0]
  }
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
  target_group_arns = ["arn:aws:elasticloadbalancing:us-east-2:562086155953:targetgroup/grg/473ec0b96cfbb086"]
  termination_policies = ["OldestInstance"]
  tag {
        key = "Environment" 
        value = "Dev"
        propagate_at_launch = true
  }
  depends_on = ["aws_launch_configuration.demo_launch_configuration"]  
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
 
   depends_on = ["aws_autoscaling_group.demo_autoscaling_group"]
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

  depends_on = ["aws_autoscaling_group.demo_autoscaling_group"]
}

resource "aws_cloudwatch_metric_alarm" "cpuutilization-high" {
    alarm_name = "CPU-Utilization-High"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "1"
    datapoints_to_alarm = "1"
    treat_missing_data = var.treat_missing_data[0]
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
    depends_on = ["aws_autoscaling_policy.scaleup_policy"]
}

resource "aws_cloudwatch_metric_alarm" "cpuutilization-low" {
    alarm_name = "CPU-Utilization-Low"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "1"
    datapoints_to_alarm = "1"
    treat_missing_data = var.treat_missing_data[0]
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
    depends_on = ["aws_autoscaling_policy.scaleup_policy"]
}

