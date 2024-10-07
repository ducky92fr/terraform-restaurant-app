resource "aws_route_table" "private_route" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }
  tags = {
    Name = "private-route-table"
  }
}


resource "aws_route_table_association" "private_association" {
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.private_route.id
}
