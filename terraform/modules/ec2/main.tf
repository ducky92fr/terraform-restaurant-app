resource "aws_instance" "my_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = var.instance_name
  }
  subnet_id = var.subnet_id
  key_name      = var.key_name
}