resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "main-internet-gateway"
  }
}

resource "aws_eip" "nat_eip" {
    tags = {
    Name = "nat-gateway-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "main-nat-gateway"
  }
}