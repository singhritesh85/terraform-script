resource "aws_internet_gateway" "myIGW" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "myIGW"
  }
}
