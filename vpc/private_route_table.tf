resource "aws_default_route_table" "default_route" {
  default_route_table_id = "${aws_vpc.myvpc.default_route_table_id}"

  tags = {
    Name = "Private_Main_Table"
  }

}
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "Private_Route_Table"
  }
}
resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_default_route_table.default_route.id
}
