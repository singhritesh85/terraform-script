variable "region" {
description = "Region of resources for AWS"
type = string
default = "us-east-2"
}
variable "instance_count" {
description = "Provide the Instance Count"
type = number
default = 3
}
variable "provide_ami" {
description = "Provide the AMI ID for the EC2 Instance"
type = map
default = {
  "us-east-1" = "ami-0cff7528ff583bf9a"
  "us-east-2" = "ami-02d1e544b84bf7502"
  "us-west-1" = "ami-0d9858aa3c6322f73"
  "us-west-2" = "ami-098e42ae54c764c35"
}
}
variable "instance_type" {
description = "Provide the Instance Type"
type = list
default = [ "t3.micro", "t3.small", "t3.medium", "t3.large", "t3.xlarge" ]
}
variable "subnet_id" {
description = "Provide the Subnet ID"
type = string
default = "subnet-68210f12"
}
variable "security_groups" {
description = "Provide the security group"
type = list
default = ["sg-047ee202717407868", "sg-023ce605fd23ea056"]
}
variable "name" {
description = "Provide the name of the EC2 Instance"
type = string
default = "Test-Instance"
}
variable "environment" {
description = "Provide the Environment as dev, test or prod"
type = string
default = "Dev"
}
