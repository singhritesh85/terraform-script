variable "region" {
default = "us-east-2"
}

variable "policy_name" {
description = "Provide the Policy Name"
type = string
default = "test-S3-Full-Access-Policy"
}

variable "role_name" {
description = "Provide the Role Name"
type = string
default = "test-Role-S3-Full-Access"
}
variable "provide_amis" {
description = "Provide the AMI for the EC2 Instance"
type = map
default = {
us-east-1 = "ami-0d5eff06f840b45e9"
us-east-2 = "ami-077e31c4939f6a2f3"
us-west-1 = "ami-04468e03c37242e1e"
us-west-2 = "ami-0cf6f5c8a62fa5da6"
}
}
variable "instance_types" {
description = "Provide the Instance Type of the Instance"
type = list
default = ["t3.micro", "t3.medium", "t3.large", "t3.xlarge"]
}
variable "key_name" {
description = "Provide the Key Name"
type = string
default = "key"
}

variable "provide_security_group" {
description = "Provide the security group to be attached"
type = string
default = "sg-06af727dd120cfe65" 
}

variable "subnet_id" {
description = "Provide the subnet ID for the EC2 Instance" 
type = string
default = "subnet-070ec2c4ff53f26c8"
}

variable "instance_name" {
description = "Provide the Instance Name"
type = string
default = "MyInstance-1"
}

variable "bucket_name" {
description = "Provide the Name of the S3 Bucket to be created"
type = string
default = "my-test-bucket-13052021"
}

variable "access_control_list" {
description = "Provide the ACL for the S3 Bucket"
type = string
default = "private"
}

variable "enabled_disabled_versioning" {
description = "To enable or disable the versioning"
type = bool
default = true
}

variable "sse_algorithm" {
description = "Provide the SSE Algorithm"
type = string
default = "AES256"
}

variable "tag" {
description = "Provide the Tag for s3 bucket"
type = string
default = "Dev"
}
