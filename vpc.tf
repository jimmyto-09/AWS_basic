resource "aws_vpc" "mi_test_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "red_test_vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.mi_test_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.mi_test_vpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.mi_test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "route_table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.route_table.id
}