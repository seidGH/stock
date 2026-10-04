resource "aws_route_table" "stock_public" {
  vpc_id = aws_vpc.stock.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.stock.id
  }

  tags = {
    Name = "stock-public-route-table"
  }
}

resource "aws_route_table_association" "stock_public" {
  subnet_id      = aws_subnet.stock_public.id
  route_table_id = aws_route_table.stock_public.id
}
