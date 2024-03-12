resource "aws_route_table_association" "vincent_public_subnet_association" {
  count          = length(aws_subnet.vincent_private_subnet)
  subnet_id      = aws_subnet.vincent_public_subnet[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}

resource "aws_route_table_association" "vincent_private_subnet_association" {
  count          = length(aws_subnet.vincent_private_subnet)
  subnet_id      = aws_subnet.vincent_private_subnet[count.index].id
  route_table_id = aws_route_table.private[count.index].id

}