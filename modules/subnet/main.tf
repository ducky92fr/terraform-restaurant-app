resource "aws_subnet" "mysubnet" {
  vpc_id   = aws_vpc.my_vpc.id
  cidr_block = var.cidr_block
  availability_zone = var.availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch
  
  tags = {
    Name = "${var.type}-subnet-${var.key}"
  }
}

