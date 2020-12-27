variable "region" {
description = "Region into which to create the AWS Resource"
type = string
default = "us-east-2"
}
variable "hosted_zone_name" {
description = "Provide the hosted zone name"
type = string
}
