resource "aws_eip" "nat_eip" {
    tags = {
    Name = "nat-gateway-eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = var.nat_gateway_name
  }
}