resource "aws_route_table" "public" {
  count  = length(var.availability_zone)
  vpc_id = aws_vpc.vincent_vpc.id

  tags = merge(var.tags, {
    Name = format("%s-%s-%s-public-route-table-%d-%s", var.tags["id"], var.tags["environment"], var.tags["project"], count.index + 1, element(var.availability_zone, count.index))
  })
}

resource "aws_route" "public_internet_gateway" {
  count                  = length(var.availability_zone)
  route_table_id         = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vincent_igw.id

}

resource "aws_route_table" "private" {
  count  = length(var.availability_zone)
  vpc_id = aws_vpc.vincent_vpc.id

  tags = merge(var.tags, {
    Name = format("%s-%s-%s-private-route-table-%d-%s", var.tags["id"], var.tags["environment"], var.tags["project"], count.index + 1, element(var.availability_zone, count.index))
  })
}

resource "aws_route" "nat_gateway" {
  count                  = length(var.availability_zone)
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.vincent_nat_gateway[count.index].id

}