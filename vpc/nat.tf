resource "aws_eip" "nat" {
  vpc      = true
}
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.subnet3.id
  depends_on    = [aws_internet_gateway.myIGW]

  tags = {
    Name = "NAT_Gateway"
  }
}
