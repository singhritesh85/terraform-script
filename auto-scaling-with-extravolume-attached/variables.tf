variable "region" {
description = "AWS Region into which AWS Resource is supposed to be created"
type = string
default = "us-east-2"
}
variable "launch_configuration_name" {
description = "Provide the Name of the Launch Configuration"
type = string
}
variable "instance_type" {
description = "The Instance Type of the EC2 Instance to be launched"
type = list
default = ["t3.micro", "t3.medium", "t3.large", "t3.xlarge", "t3.2xlarge"]
}
variable "launch_configuration_image_id" {
description = "Image Id of the EC2 Instance to be launched"
type = string
default = "ami-01a159bd0e43d53ff"
}
variable "iam_instance_profile" {
description = "Provide the IAM Role to be attached with EC2 Instance"
type = string
default = "Administrator_Role"
}
variable "enable_monitoring" {
description = "Select the value to enable or disable monitoring"
type = bool
default = true
}
variable "ebs_optimized" {
description = "If true, the launched EC2 instance will be EBS-optimized"
type = list
default = [true, false]
}
variable "key_name" {
description = "Select the Key-Pair of the EC2 Instance"
type = list
default = ["key", "myown", "test", "Test-KeyPair"]
}
variable "security_groups" {
description = "A list of associated security group IDS."
type = list
default = ["sg-04be052143c79bd66", "sg-0fa141a9899965afb", "sg-052bb7b5d14ee0dd7"]
}
variable "associate_public_ip_address" {
description = "Associate a public ip address with an instance in a VPC."
type = bool
default = true
}
variable "placement_tenancy" {
description = "The tenancy of the instance. Valid values are default or dedicated."
type = list
default = ["default", "dedicated"]
}
variable "device_name" {
description = "The name of the device to mount."
type = string
default = "/dev/sdb"
}
variable "volume_type" {
description = "The type of volume. Can be standard, gp2, or io1"
type = list
default = ["standard", "gp2", "io1"]
}
variable "volume_size" {
description = "The size of the volume in gigabytes(GB)"
type = number
default = 20
}
variable "iops" {
description = "The amount of provisioned IOPS."
type = number
default = 100
}
variable "delete_on_termination" {
description = "Whether the volume should be encrypted or not."
type = list
default = [true, false]
}
variable "encrypted" {
description = "Whether the volume should be encrypted or not. Do not use this option if you are using snapshot_id as the encrypted flag will be determined by the snapshot."
type = list 
default = [true, false]
}

#######################variables for Autoscaling Group###############################

variable "min_size" {
description = "Minimum size for Autoscaling Group"
type = number
default = 1
}
variable "max_size" {
description = "Maximum size for Autoscaling Group"
type = number
default = 3
}
variable "desired_capacity" {
description = "Desired capacity for Autoscaling Group"
type = number
default = 1
}
variable "default_cooldown" {
description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
type = number
default = 10
}
variable "service_linked_role_arn" {
description = "The ARN of the service-linked role that the ASG will use to call other AWS services."
type = string
default = "arn:aws:iam::562086155953:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
}
variable "health_check_type" {
description = "Controls how health checking is done"
type = list
default = ["EC2", "ELB"]
}

#######################################cloudwatch for AutoScaling Group###############################################

variable "treat_missing_data" {
description = "Sets how this alarm is to handle missing data points."
type = list
default = ["missing", "ignore", "breaching", "notBreaching"]
}
