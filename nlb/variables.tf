variable "region" {
description = "Provide the region of AWS into which to create the ALB"
type = string
default = "us-east-2"
}
variable "network_loadbalancer_name" {
description = "Provide the Network Loadbalancer Name"
type = string
}
variable "internal" {
description = "Whether the lodbalancer is internet facing or internal"
type = bool
default = false
}
variable "load_balancer_type" {
description = "Provide the type of the loadbalancer"
type = string
default = "network"
}
variable "subnets" {
description = "List of subnets for Loadbalancer"
type = list
default = ["subnet-5d85d427", "subnet-e116afad", "subnet-ea2f3482"]
}
variable "enable_deletion_protection" {
description = "To disavle or enable the deletion protection of loadbalancer"
type = bool
default = false
}
variable "enable_cross_zone_load_balancing" {
description = "To Enable Cross-Zone Loadbalancing"
type = bool
default = true
}
variable "access_log_bucket" {
description = "S3 bucket to capture Application LoadBalancer"
type = string
default = "demobucket201911"
}
variable "prefix" {
description = "Provide the s3 bucket folder name"
type = string
default = "network_loadbalancer_log_folder"
}
variable "idle_timeout" {
description = "The time in seconds that the connection is allowed to be idle."
type = number
default = 60
}
variable "enabled" {
description = "To capture access log into s3 bucket or not"
type = bool
default = true
}
variable "target_group_name" {
description = "Provide Target Group Name for Network Loadbalancer"
type = string
}
variable "instance_port" {    #### Don't apply when target_type is lambda
description = "Instance Port on which Application will run"
type = list
default = [80, 53]
}
variable "instance_protocol" {          #####Don't use protocol when target type is lambda
description = "The protocol to use for routing traffic to the targets."
type = list
default = ["TCP", "TCP_UDP"]
}
variable "target_type_alb" {
description = "Select the target type of the Application LoadBalancer"
type = list
default = ["instance", "ip", "lambda"]
}
variable "vpc_id" {
description = "The identifier of the VPC in which to create the target group."
type = string
default = "vpc-128a7979"
}
variable "load_balancing_algorithm_type" {
description = "Determines how the load balancer selects targets when routing requests. Only applicable for Application Load Balancer Target Groups."
type = list
default = ["round_robin", "least_outstanding_requests"]
}
variable "stickiness_type" {  ## The type of sticky sessions. The only current possible values are lb_cookie for ALBs and source_ip for NLBs.
description = "Select the stickiness type"
type = list
default = ["lb_cookie", "source_ip"]
}
variable "cookie_duration" {
description = "Only used when the type is lb_cookie. The time period, in seconds, during which requests from a client should be routed to the same target. After this time period expires, the load balancer-generated cookie is considered stale. The range is 1 second to 1 week (604800 seconds). The default value is 1 day (86400 seconds)."
type = number
default = 86400
}
variable "health_check_protocol" {
description = "Heath Check Protocol for Network Loadbalancer"
type = list
default = ["HTTP", "HTTPS", "TCP"]
}
variable "health_check_port" {
description = "Port used for health check"
type = list
default = ["80", "443"]
}
variable "healthy_threshold" {
description = "Provide healthy threshold in seconds, the number of checks before the instance is declared healthy"
type = number
default = 2
}
variable "unhealthy_threshold" {
description = "Provide unhealthy threshold in seconds, the number of checks before the instance is declared unhealthy"
type = number
default = 2
}
variable "timeout" {
description = "Provide the timeout in seconds, the length of time before the check times out."
type = number
default = 3
}
variable "interval" {
description = "The interval between checks."
type = string
default = 30
}
variable "target_port_path" {
description = "Port and Path for Target of Application LoadBalancer"
type = string
default = "HTTP:80/index.html"
}
variable "ssl_policy" {
description = "Select the SSl Policy for the Application Loadbalancer"
type = list
default = ["ELBSecurityPolicy-2016-08", "ELBSecurityPolicy-TLS-1-2-2017-01", "ELBSecurityPolicy-TLS-1-1-2017-01", "ELBSecurityPolicy-TLS-1-2-Ext-2018-06", "ELBSecurityPolicy-FS-2018-06", "ELBSecurityPolicy-2015-05"]
}
variable "certificate_arn" {
description = "Provide the SSL Certificate ARN from AWS Certificate Manager"
type = string
default = "arn:aws:acm:us-east-2:562086155953:certificate/6c5f1f64-d2b7-4680-8133-4c2623f58d55"
}
variable "type" {
description = "The type of routing action."
type = list
default = ["forward", "redirect", "fixed-response"]
}
variable "listener_protocol_TCP" {
description = "listener protocol for network loadbalancer"
type = list
default = ["TCP", "UDP"]
}
