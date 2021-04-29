variable "region"{
description = "Provide the AWS Region"
type = string
default = "us-east-2"
}

variable "vpc_cidr"{
description = "Provide the CIDR for VPC"
type = string
default = "10.10.0.0/16"
}

variable "private_subnet_cidr"{
description = "Provide the cidr for Private Subnet"
type = list
default = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "public_subnet_cidr"{
description = "Provide the cidr of the Public Subnet"
type = list
default = ["10.10.3.0/24", "10.10.4.0/24", "10.10.5.0/24"]
}

data "aws_availability_zones" "azs" {
}
