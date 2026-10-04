resource "aws_instance" "stock" {
  ami           = "ami-086ab3271ce53767d"
  instance_type = "t3.micro"

  subnet_id = aws_subnet.stock_public.id

  key_name = aws_key_pair.stock.key_name

  vpc_security_group_ids = [
    aws_security_group.stock.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "stock-server"
  }
}
