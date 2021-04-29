variable "region" {
description = "Provide the region of EC2 Instance to be created"
type = string
default = "us-east-2"
}

variable "web_count" {
description = "Provide the number of Instances to be launched"
type = string
default = "2"
}

variable "web_ami" {
description = "Provide the AMI of the Instance to be launched"
type = map
default = {
  us-east-1 = "ami-0f57b4cec24530068"
  us-east-2 = "ami-0f57b4cec24530068"
}
}

variable "web_instance_type" {
description = "Provide the Instance Type of the Instance"
type = list
default = ["t3.micro", "t3.medium", "t3.large"]
}

variable "provide_subnet_id" {
description = "Provide the Subnet Ids"
type = list
default = ["subnet-0aa2f6db76b98b6f5", "subnet-0c264c0d8d83ca28b", "subnet-030e9ce6b80934b89"]
}

data "aws_availability_zones" "azs" {
}
