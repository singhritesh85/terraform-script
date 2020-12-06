resource "aws_vpc" "myvpc" {
  cidr_block       = var.cidr
  instance_tenancy = var.instance_tenancy
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = "VPC-1"
  }
}
