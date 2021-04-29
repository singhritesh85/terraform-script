resource "aws_internet_gateway" "testIGW" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "test-IGW"
    Environment = "${terraform.workspace}"
  }
}
