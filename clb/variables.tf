variable "region" {
description = "AWS Region to whichEC2 Instance to be launched"
type = string
default = "us-east-2"
}
variable "classic_loadbalancer_name" {
description = "Provide the name of the classic loadbalancer"
type = string
}
variable "Availabilty_Zone" {
description = "Availability Zone for Classic LoadBalancer"
type = list
default = ["us-east-2a", "us-east-2b", "us-east-2c"]
}
variable "instances" {
description = "Attach instances to the Classic LoadBalancer"
type = list
default = ["i-0d8376af2428cf5f5", "i-0a3487c208f3ef9d8"]
}
variable "ssl_certificate_id" {
description = "Provide ARN of SSL Certificate"
type = string
default = "arn:aws:acm:us-east-2:562086155953:certificate/6c5f1f64-d2b7-4680-8133-4c2623f58d55"
}
variable "cross_zone_load_balancing" {
description = "Enable or disable cross zone LoadBalancing"
type = bool
default = true
}
variable "target_port_path" {
description = "Port and Path for Target of Application LoadBalancer"
type = string
default = "HTTP:80/index.html"
}
variable "bucket" {
description = "S3 Bucket Name"
type = string
default = "demobucket201911"
}
variable "bucket_folder" {
description = "The folder into which LoadBalancer logs to be exported"
type = string
default = "test_bucket"
}
variable "access_log_interval" {
description = "Interval in seconds after which logs to be exported into the s3 bucket"
type = number
default = 60
}
variable "connection_draining" {
description = "Select true or false for connection draining"
type = bool
default = true
}
variable "connection_draining_timeout" {
description = "Connection draining timeout in seconds"
type = number
default = 300
}
variable "idle_timeout" {
description = "Provide idle time-out in seconds for Classic LoadBalancer"
type = number
default = 60
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
