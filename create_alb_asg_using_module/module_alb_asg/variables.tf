################### variables for LoadBalancer #################################

#variable "region" {
#description = "Provide the region of AWS into which to create the ALB"
#type = string
#default = "us-east-2"
#}
variable "application_loadbalancer_name" {
#description = "Provide the Application Loadbalancer Name"
#type = string
}
variable "internal" {
#description = "Whether the lodbalancer is internet facing or internal"
#type = bool
#default = false
}
variable "load_balancer_type" {
#description = "Provide the type of the loadbalancer"
#type = string
#default = "application"
}
variable "subnets" {
#description = "List of subnets for Loadbalancer"
#type = list
#default = ["subnet-5d85d427", "subnet-e116afad", "subnet-ea2f3482"]
}
variable "loadbalancer_security_groups" {     ## Security groups are not supported for network load balancers
#description = "List of security Groups for Loadbalancer"
#type = list
#default = ["sg-04be052143c79bd66", "sg-06601d6818362f774", "sg-0fa141a9899965afb"]
}
variable "enable_deletion_protection" {
#description = "To disavle or enable the deletion protection of loadbalancer"
#type = bool
#default = false
}
variable "access_log_bucket" {
#description = "S3 bucket to capture Application LoadBalancer"
#type = string
#default = "demobucket201911"
}
variable "prefix" {
#description = "Provide the s3 bucket folder name"
#type = string
#default = "application_loadbalancer_log_folder"
}
variable "idle_timeout" {
#description = "The time in seconds that the connection is allowed to be idle."
#type = number
#default = 60
}
variable "enabled" {
#description = "To capture access log into s3 bucket or not"
#type = bool
#default = true
}
variable "target_group_name" {
#description = "Provide Target Group Name for Application Loadbalancer"
#type = string
}
variable "instance_port" {    #### Don't apply when target_type is lambda
#description = "Instance Port on which Application will run"
#type = number
#default = 80
}
variable "instance_protocol" {          #####Don't use protocol when target type is lambda
#description = "The protocol to use for routing traffic to the targets."
#type = string
#default = "HTTP"
}
variable "target_type_alb" {
#description = "Select the target type of the Application LoadBalancer"
#type = list
#default = ["instance", "ip", "lambda"]
}
variable "vpc_id" {
#description = "The identifier of the VPC in which to create the target group."
#type = string
#default = "vpc-128a7979"
}
variable "load_balancing_algorithm_type" {
#description = "Determines how the load balancer selects targets when routing requests. Only applicable for Application Load Balancer Target Groups."
#type = list
#default = ["round_robin", "least_outstanding_requests"]
}
variable "stickiness_type" {  ## The type of sticky sessions. The only current possible values are lb_cookie for ALBs and source_ip for NLBs.
#description = "Select the stickiness type"
#type = list
#default = ["lb_cookie", "source_ip"]
}
variable "cookie_duration" {
#description = "Only used when the type is lb_cookie. The time period, in seconds, during which requests from a client should be routed to the same target. After this time period expires, the load balancer-generated cookie is considered stale. The range is 1 second to 1 week (604800 seconds). The default value is 1 day (86400 seconds)."
#type = number
#default = 86400
}
variable "healthy_threshold" {
#description = "Provide healthy threshold in seconds, the number of checks before the instance is declared healthy"
#type = number
#default = 2
}
variable "unhealthy_threshold" {
#description = "Provide unhealthy threshold in seconds, the number of checks before the instance is declared unhealthy"
#type = number
#default = 2
}
variable "timeout" {
#description = "Provide the timeout in seconds, the length of time before the check times out."
#type = number
#default = 3
}
variable "interval" {
#description = "The interval between checks."
#type = string
#default = 30
}
variable "target_port_path" {
#description = "Port and Path for Target of Application LoadBalancer"
#type = string
#default = "HTTP:80/index.html"
}
variable "ssl_policy" {
#description = "Select the SSl Policy for the Application Loadbalancer"
#type = list
#default = ["ELBSecurityPolicy-2016-08", "ELBSecurityPolicy-TLS-1-2-2017-01", "ELBSecurityPolicy-TLS-1-1-2017-01", "ELBSecurityPolicy-TLS-1-2-Ext-2018-06", "ELBSecurityPolicy-FS-2018-06", "ELBSecurityPolicy-2015-05"]
}
variable "certificate_arn" {
#description = "Provide the SSL Certificate ARN from AWS Certificate Manager"
#type = string
#default = "arn:aws:acm:us-east-2:562086155953:certificate/6c5f1f64-d2b7-4680-8133-4c2623f58d55"
}
variable "http_type" {
#description = "The type of routing action."
#type = list
#default = ["forward", "redirect", "fixed-response"]
}

variable "https_type" {
#description = "The type of routing action."
#type = list
#default = ["forward", "redirect", "fixed-response"]
}

################### variables for Launch Configuration #########################

variable "launch_configuration_name" {
#description = "Provide the Name of the Launch Configuration"
#type = string
}
variable "instance_type" {
#description = "The Instance Type of the EC2 Instance to be launched"
#type = list
#default = ["t3.micro", "t3.medium", "t3.large", "t3.xlarge", "t3.2xlarge"]
}
variable "launch_configuration_image_id" {
#description = "Image Id of the EC2 Instance to be launched"
#type = string
#default = "ami-01a159bd0e43d53ff"
}
variable "iam_instance_profile" {
#description = "Provide the IAM Role to be attached with EC2 Instance"
#type = string
#default = "Administrator_Role"
}
variable "enable_monitoring" {
#description = "Select the value to enable or disable monitoring"
#type = bool
#default = true
}
variable "ebs_optimized" {
#description = "If true, the launched EC2 instance will be EBS-optimized"
#type = list
#default = [true, false]
}
variable "key_name" {
#description = "Select the Key-Pair of the EC2 Instance"
#type = list
#default = ["key", "myown", "test", "Test-KeyPair"]
}
variable "security_groups" {
#description = "A list of associated security group IDS."
#type = list
#default = ["sg-04be052143c79bd66", "sg-0fa141a9899965afb", "sg-052bb7b5d14ee0dd7"]
}
variable "associate_public_ip_address" {
#description = "Associate a public ip address with an instance in a VPC."
#type = bool
#default = true
}
variable "placement_tenancy" {
#description = "The tenancy of the instance. Valid values are default or dedicated."
#type = list
#default = ["default", "dedicated"]
}
/*variable "device_name" {
description = "The name of the device to mount."
type = string
#default = "/dev/sdb"
}
variable "volume_type" {
description = "The type of volume. Can be standard, gp2, or io1"
type = list
#default = ["standard", "gp2", "io1"]
}
variable "volume_size" {
description = "The size of the volume in gigabytes(GB)"
type = number
#default = 20
}
variable "iops" {
description = "The amount of provisioned IOPS."
type = number
#default = 100
}
variable "delete_on_termination" {
description = "Whether the volume should be encrypted or not."
type = list
#default = [true, false]
}
variable "encrypted" {
description = "Whether the volume should be encrypted or not. Do not use this option if you are using snapshot_id as the encrypted flag will be determined by the snapshot."
type = list 
#default = [true, false]
}*/

#######################variables for Autoscaling Group###############################

variable "min_size" {
#description = "Minimum size for Autoscaling Group"
#type = number
#default = 1
}
variable "max_size" {
#description = "Maximum size for Autoscaling Group"
#type = number
#default = 3
}
variable "desired_capacity" {
#description = "Desired capacity for Autoscaling Group"
#type = number
#default = 1
}
variable "default_cooldown" {
#description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
#type = number
#default = 10
}
variable "service_linked_role_arn" {
#description = "The ARN of the service-linked role that the ASG will use to call other AWS services."
#type = string
#default = "arn:aws:iam::562086155953:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
}
variable "health_check_type" {
#description = "Controls how health checking is done"
#type = list
#default = ["EC2", "ELB"]
}

#######################################cloudwatch for AutoScaling Group###############################################

variable "treat_missing_data" {
#description = "Sets how this alarm is to handle missing data points."
#type = list
#default = ["missing", "ignore", "breaching", "notBreaching"]
}
