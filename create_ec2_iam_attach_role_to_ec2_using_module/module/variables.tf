variable "region" {
default = "us-east-2"
}
variable "iam_policy_name" {
description = "Provide the IAM Policy Name"
type = string
default = "ec2-instance-policy"
}
variable "iam_role_name" {
description = "Provide the IAM Role Name"
type = string
default = "ec2-instance-role"
}
variable "iam_profile_name" {
description = "Provide the IAM profile name"
type = string
default = "ec2-profile"
}
variable "policy" {
default = "policy.json"
}
variable "trustedadvisor" {
default = "trusted-advisor.json"
}
variable "provide_ami" {
description = "Provide the AMI ID for the EC2 Instance"
type = map
default = {
    us-east-1 = "ami-04d29b6f966df1537"
    us-east-2 = "ami-09558250a3419e7d0"
    us-west-1 = "ami-08d9a394ac1c2994c"
    us-west-2 = "ami-0e472933a1395e172"
}
}
variable "instance_type" {
description = "Provide the Instance type of the EC2 Instance"
type = list
default = ["t3.micro", "t3.small", "t3.medium", "t3.large", "t3.xlarge", "t3.2xlarge"]
}
variable "security_group" {
description = "Provide the Security Group ID of the security Groups"
type = list
default = [ "sg-06af727dd120cfe65" ]
}
variable "subnet_id" {
description = "Provide the subnet Id of the subnet"
type = string
default = "subnet-070ec2c4ff53f26c8"
}
variable "instance_name" {
description = "Provide the Instance Name"
type = string
default = "MyInstance-1"
}
variable "environment" {
description = "Provide the Environment Name"
type = string
default = "Dev"
}
