# Create Route Table for Public Subnets
resource "aws_route_table" "vincent_public_route" {
  vpc_id = aws_vpc.vincent_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vincent_igw.id
  }

  tags = merge(var.tags, {
    Name = "${var.tags["id"]}-vincent_public_route"
  })
}


# Create Route Table for Private Subnets
resource "aws_route_table" "vincent_private_route" {
  vpc_id = aws_vpc.vincent_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.vincent_nat_gateway[0].id
  }

  tags = merge(var.tags, {
    Name = "${var.tags["id"]}-vincent_public-route"
  })
}




