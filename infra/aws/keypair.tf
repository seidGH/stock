resource "aws_key_pair" "stock" {
  key_name   = "stock-ec2-key"
  public_key = file("~/.ssh/stock-ec2.pub")

  tags = {
    Name = "stock-ec2-key"
  }
}
