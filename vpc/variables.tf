variable "region" {
  type = string
  default = "us-east-2"
}
variable "cidr" {
  description = "The CIDR block of VPC."
  type = string
  default = "10.20.0.0/16"
}
variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC."
  type = string
  default = "default"
}
variable "enable_dns_support" {
  description = "Select Option to enable the DNS Support"
  type = bool
  default = true
}
variable "enable_dns_hostnames" {
  description = "Select Option to enable the DNS hostname"
  type = bool
  default = true
}
