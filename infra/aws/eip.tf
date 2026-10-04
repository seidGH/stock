resource "aws_eip" "stock" {
  domain = "vpc"

  tags = {
    Name = "stock-eip"
  }
}

resource "aws_eip_association" "stock" {
  instance_id   = aws_instance.stock.id
  allocation_id = aws_eip.stock.id
}
