variable "region" {
  description = "Region in which EC2 Instance to be launched"
  type = string
  default = "us-east-2"
}
variable "provide_ami" {
  type = map
  default = {
    us-east-1 = "ami-04d29b6f966df1537"
    us-east-2 = "ami-09558250a3419e7d0"
    us-west-1 = "ami-08d9a394ac1c2994c"
    us-west-2 = "ami-0e472933a1395e172"
  }
}
variable "provide_instance_type" {
description = "Provide the Instance type of the EC2 Instance"
type = list
default = ["t3.micro", "t3.medium", "t3.large"]
}
variable "key_name" {
description = "Provide the Key-Pair Name with which the EC2 to be launched"
type = string
default = "key"
}
variable "security_group" {
description = "Provide the security group id of the security group"
type = string
default = "sg-06af727dd120cfe65"
}
variable "subnet_id" {
description = "Provide the subnet id into which the ec2 instance will be launched"
type = string
default = "subnet-070ec2c4ff53f26c8"
}
variable "environment" {
description = "Provide the environment for the EC2 Instance to be launched"
type = string
default = "Dev"
}
