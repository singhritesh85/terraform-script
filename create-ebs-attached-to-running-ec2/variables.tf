variable "region" {
description = "Region into which to create the AWS Resource"
type = string
default = "us-east-2"
}
variable "volume_size" {
description = "Provide the EBS Volume Size to be created"
type = number
}
variable "ebs_type" {
description = "Provide the EBS Volume Type"
type = list
default = ["standard", "gp2", "io1", "io2", "sc1", "st1"]
}
