variable "region" {
description = "Provide the AWS Region"
type = string
}
variable "count_no_master" {
description = "Provide the Number of Instances to be launched"
type = number
}
variable "count_no_worker" {
description = "Provide the Number of Instances to be launched"
type = number
}
variable "amis" {
description = "The AMI using whcih EC2 will be created"
type = map
default = {
    "us-east-1" = "ami-0affd4508a5d2481b"
    "us-west-2" = "ami-0bc06212a56393ee1"
    "us-east-2" = "ami-01e36b7901e884a10"
  }
}
variable "subnet_id" {
description = "Provide the subnet id"
type = string
}
variable "instance_type" {
description = "Provide the instance type of the EC2 Instance"
type = list
}
variable "associate_public_ip_address" {
description = "Public IP should be associated or not"
type = list
}
variable "volume_type" {
description = "Provide the Volume Type"
type = list
}
variable "volume_size" {
description = "Provide the EC2 Instance Volume Size"
type = number
}
variable "kms_key_id" {
description = "Provide the KMS Key ID"
type = string
}
variable "master_name" {
description = "Provide the kubernetes master name"
type = string
}
variable "worker_name" {
description = "Provide the kubernetes worker name"
type = string
}
variable "inventory_file" {
description = "provide the name of inventory file"
type = string
}
variable "iam_policy_name" {
description = "Provide the IAM Policy Name"
type = string
#default = "ec2-instance-policy"
}
variable "iam_role_name" {
description = "Provide the IAM Role Name"
type = string
#default = "ec2-instance-role"
}
variable "iam_profile_name" {
description = "Provide the IAM profile name"
type = string
#default = "ec2-profile"
}
variable "policy" {
default = "policy.json"
}
variable "trustedadvisor" {
default = "trusted-advisor.json"
}
