variable "region" {
  description = "Provide the AWS Region into which Resource to be created"
  type = string
}
variable "provide_ami" {
description = "Provide the AMI ID for the EC2 Instance"
type = map
}
variable "instance_type" {
description = "Provide the Instance type of the EC2 Instance"
type = list
}
variable "security_group" {
description = "Provide the Security Group ID of the security Groups"
type = list
}
variable "subnet_id" {
description = "Provide the subnet Id of the subnet"
type = string
}
variable "instance_name" {
description = "Provide the Instance Name"
type = string
}
variable "environment" {
description = "Provide the Environment Name"
type = string
}

variable "application_loadbalancer_name" {
description = "Provide the Application Loadbalancer Name"
type = string
default = "tomcat-alb"
}
variable "internal" {
description = "Whether the lodbalancer is internet facing or internal"
type = bool
default = false
}
variable "load_balancer_type" {
description = "Provide the type of the loadbalancer"
type = string
default = "application"
}
variable "subnets" {
description = "List of subnets for Loadbalancer"
type = list
default = ["subnet-XXXXXXXX", "subnet-XXXXXXXX", "subnet-XXXXXXXX"]
}
variable "enable_deletion_protection" {
description = "To disavle or enable the deletion protection of loadbalancer"
type = bool
default = false
}
variable "idle_timeout" {
description = "The time in seconds that the connection is allowed to be idle."
type = number
default = 60
}
variable "target_group_name" {
description = "Provide Target Group Name for Application Loadbalancer"
type = string
default = "tomcat-tg"
}
variable "instance_port" {    #### Don't apply when target_type is lambda
description = "Instance Port on which Application will run"
type = number
default = 80
}
variable "instance_protocol" {          #####Don't use protocol when target type is lambda
description = "The protocol to use for routing traffic to the targets."
type = string
default = "HTTP"
}
variable "target_type_alb" {
description = "Select the target type of the Application LoadBalancer"
type = list
default = ["instance", "ip", "lambda"]
}
variable "vpc_id" {
description = "The identifier of the VPC in which to create the target group."
type = string
default = "vpc-XXXXXXXXX"
}
variable "load_balancing_algorithm_type" {
description = "Determines how the load balancer selects targets when routing requests. Only applicable for Application Load Balancer Target Groups."
type = list
default = ["round_robin", "least_outstanding_requests"]
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
default = "HTTP:80/"
}
variable "ssl_policy" {
description = "Select the SSl Policy for the Application Loadbalancer"
type = list
default = ["ELBSecurityPolicy-2016-08", "ELBSecurityPolicy-TLS-1-2-2017-01", "ELBSecurityPolicy-TLS-1-1-2017-01", "ELBSecurityPolicy-TLS-1-2-Ext-2018-06", "ELBSecurityPolicy-FS-2018-06", "ELBSecurityPolicy-2015-05"]
}
variable "certificate_arn" {
description = "Provide the SSL Certificate ARN from AWS Certificate Manager"
type = string
default = "arn:aws:acm:us-east-2:XXXXXXXXX:certificate/XXXXXXX-XXXX-XXXX-XXXX-f7XXXXXXXXfe6"
}
variable "type" {
description = "The type of routing action."
type = list
default = ["forward", "redirect", "fixed-response"]
}
