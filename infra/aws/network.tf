resource "aws_vpc" "stock" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "stock-vpc"
  }
}


resource "aws_subnet" "stock_public" {
  vpc_id                  = aws_vpc.stock.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "stock-public-subnet"
  }
}

resource "aws_internet_gateway" "stock" {
  vpc_id = aws_vpc.stock.id

  tags = {
    Name = "stock-igw"
  }
}
