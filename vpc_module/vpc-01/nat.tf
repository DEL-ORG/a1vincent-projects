resource "aws_nat_gateway" "vincent_nat_gateway" {
  count         = length(var.availability_zone)
  subnet_id     = aws_subnet.vincent_public_subnet[count.index].id
  allocation_id = aws_eip.vincent_eip[count.index].id

  tags = merge(var.tags, {
    Name = format("%s-%s-%s-nat-%d-%s", var.tags["id"], var.tags["environment"], var.tags["project"], count.index + 1, element(var.availability_zone, count.index))
  })
}