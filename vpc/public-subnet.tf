resource "aws_subnet" "subnet3" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.20.3.0/24"
  availability_zone = "us-east-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet3"
  }
}
