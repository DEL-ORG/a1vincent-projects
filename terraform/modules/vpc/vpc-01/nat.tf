resource "aws_nat_gateway" "vincent_nat_gateway" {
  allocation_id = aws_eip.vincent_eip.id
  subnet_id     = element(aws_subnet.vincent_public_subnet.*.id, 0)
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-nat", var.tags["id"], var.tags["environment"], var.tags["project"])
  })
}

