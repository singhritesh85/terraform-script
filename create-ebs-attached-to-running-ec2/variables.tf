variable "region" {
description = "Region into which to create the AWS Resource"
type = string
default = "us-east-2"
}
variable "volume_size" {
description = "Provide the EBS Volume Size to be created"
type = number
}
