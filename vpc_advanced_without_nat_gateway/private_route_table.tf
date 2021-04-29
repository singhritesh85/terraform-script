resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.test_vpc.default_route_table_id
 
   tags = {
    Name = "default-route-table"
    Environment = "${terraform.workspace}"
  }

}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.test_vpc.id

  route = []

  tags = {
    Name = "Private-route-table"
   Environment = "${terraform.workspace}"
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  count = "${length(slice(data.aws_availability_zones.azs.names, 0, 2))}"
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}
