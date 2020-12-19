variable "region" {
  description = "Region in which EC2 Instance to be launched"
  type = string
  default = "us-east-2"
}
variable "availability_zone" {
  type = list
  default = ["us-east-2a", "us-east-2b", "us-east-2c"]
}
variable "ami" {
  type = map
  default = {
    us-east-1 = "ami-04d29b6f966df1537"
    us-east-2 = "ami-09558250a3419e7d0"
    us-west-1 = "ami-08d9a394ac1c2994c"
    us-west-2 = "ami-0e472933a1395e172"
  }
}
variable "counts" {
  description = "Provide the number of counts"
  type = number
}
