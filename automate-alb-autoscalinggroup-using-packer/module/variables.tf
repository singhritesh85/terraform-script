variable "bucket" {
description = "Provide the bucket name into which Access Logs of Loadbalancer will be captured"
type = string
default = "dablo"
}
variable "prefix" {
description = "Provide the path in bucket whereAccess logs will be captured"
type = string
default = "tetra/bolo"
}
variable "alb_tg_name" {
description = "Provide the Target Group Name"
type = string
default = "autoscale-tg"
}
variable "sg_name" {
description = "Provide the security group name"
type = string
default = "alb-test-sg"
}
variable "sg_description" {
description = "Description for Security group for ALB"
type = string
default = "Security Group for ALB for Autoscaling"
}
variable "vpc_id" {
description = "Provide the VPC ID"
type = string
default = "vpc-307cb55b"
}
variable "cidr_blocks" {
description = "Provide CIDR Block for Security Group"
type = list
default = ["122.161.XX.XXX/32"]
}
variable "alb_name" {
description = "Provide the ALB Name"
type = string
default = "test-alb-autoscale"
}
variable "internal_external" {
description = "Provide the option for LoadBalancer to be internal or external"
default = false
}
variable "instance_port" {
description = "Provide the Instance Port for Target Group"
type = number
default = 80
}
variable "instance_protocol" {
description = "Provide the protocol for the Target Group"
type = string
default = "HTTP"
}
variable "loadbalancer_type" {
description = "Provide the LoadBalancer Type"
type = list
default = ["application", "network"]
}
variable "subnets" {
description = "Provide the Subnet IDs"
type = list
default = ["subnet-329c6c59", "subnet-68210f12", "subnet-8377e1cf"]
}
variable "enable_deletion_protection" {
description = "To enable or disable the deletion protection"
type = bool
default = false
}
variable "target_type" {
description = "Select the target type from the list"
type = list
default = ["instance", "ip", "lambda"]
}
variable "cookie_duration" {
description = "Provide the cookie duration in seconds for sticky session"
type = number
default = 300
}
variable "stickiness_type" {
description = "Select the stickiness type"
type = list
default = ["lb_cookie", "source_ip"]
}
variable "healthy_threshold" {
description = "Provide the healthy threshold"
type = number
default = 2
}
variable "interval" {
description = "Provide the interval for health check of loadbalancer"
type = number
default = 30
}
variable "unhealthy_threshold" {
description = "Provide the unhealthy threshold"
type = number
default = 2
}
variable "timeout" {
description = "Provide the timeout time in seconds"
type = number
default = 5
}
variable "healthcheck_path" {
description = "Provide the health check path"
type = string
default = "/index.html"
}
variable "healthcheck_protocol" {
description = "Provide the healthcheck protocol"
type = string
default = "HTTP"
}
variable "ssl_policy" {
description = "Provide the SSL Policy for SSL Certificate"
type = list
default = ["ELBSecurityPolicy-2016-08", "ELBSecurityPolicy-TLS-1-2-2017-01", "ELBSecurityPolicy-TLS-1-1-2017-01", "ELBSecurityPolicy-TLS-1-2-Ext-2018-06", "ELBSecurityPolicy-FS-2018-06", "ELBSecurityPolicy-2015-05"]
}
variable "certificate_arn" {
description = "Provide the AWS certificate ARN"
type = string
default = "arn:aws:acm:us-east-2:694148179922:certificate/a8f3d156-3b1a-40d6-a947-18e7c8bb5192"
}
variable "launchconfiguration_name" {
description = "Provide the Launchconfiguration Name"
type = string
default = "MyLC"
}
#variable "image_id" {
#description = "Provide the Image ID"
#type = string
#default = 
#}
variable "instance_type" {
description = "Provide the Instance Type"
type = list
default = ["t3.micro", "t3.small", "t3.medium", "t3.large", "t3.xlarge"]
}
variable "iam_instance_profile" {
description = "Provide the IAM Role Name to be associated with the AMI"
type = string
default = "Administrator_Access"
}
variable "key_name" {
description = "Provide the Key-Pair Name"
type = list
default = ["rks-account-key1", "rks-account-key2"]
}
variable "security_groups" {
description = "Provide the security group IDs"
type = list
default = ["sg-047ee202717407868", "sg-023ce605fd23ea056"]
}
variable "associate_public_ip_address" {
description = "Select public ip address to be associated with an instance"
type = bool
default = true
}
variable "enable_monitoring" {
description = "To enable or disable the monitoring"
type = bool
default = true
}
variable "ebs_optimized" {
description = "If true, the launched EC2 instance will be EBS-optimized"
type = list
default = [true, false]
}
variable "placement_tenancy" {
description = "The tenancy of the instance. Select default or dedicated"
type = list
default = ["default", "dedicated"]
}
variable "asg_name" {
description = "Provide the Autoscaling Group Name"
type = string
default = "Autoscaling-Group1"
}
variable "min_size" {
description = "Provide the minimum size for Autoscale Cluster"
type = number
default = 2
}
variable "max_size" {
description = "Provide the maximum size for Autoscale Cluster"
type = number
default = 4
}
variable "desired_capacity" {
description = "Provide the Desired capacity of Autoscaling Group"
type = number
default = 3
}
variable "vpc_zone_identifier" {
description = "Provide the subnet IDs for the VPC"
type = list
default = ["subnet-329c6c59", "subnet-68210f12", "subnet-8377e1cf"]
}
variable "default_cooldown" {
description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
type = number
default = 100
}
variable "service_linked_role_arn" {
description = "Provide the Service Linked Role ARN for Autoscaling"
type = string
default = "arn:aws:iam::694148179922:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
}
variable "health_check_grace_period" {
description = "Time (in seconds) after instance comes into service before checking health"
type = number
default = 100
}
variable "health_check_type" {
description = "Select the health check type as EC2 or ELB"
type = list
default = ["EC2", "ELB"]
}
variable "force_delete" {
description = "Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate"
type = bool
default = true
}
variable "treat_missing_data" {
description = "Sets how this alarm is to handle missing data points"
type = list
default = ["missing", "ignore", "breaching", "notBreaching"]
}
