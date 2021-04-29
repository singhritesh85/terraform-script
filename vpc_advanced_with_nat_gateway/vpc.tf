resource "aws_vpc" "test_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "test-vpc"
    Environment = "${terraform.workspace}"
  }
}
