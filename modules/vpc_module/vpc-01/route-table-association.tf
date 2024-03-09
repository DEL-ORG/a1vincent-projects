resource "aws_route_table_association" "public" {
  count          = length(var.availability_zone)
  subnet_id      = aws_subnet.vincent_public_subnet[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}

resource "aws_route_table_association" "private" {
  count          = length(var.availability_zone)
  subnet_id      = aws_subnet.vincent_private_subnet[count.index].id
  route_table_id = aws_route_table.private[count.index].id

}