resource "aws_eip" "vincent_eip" {
  count = length(var.availability_zone)
  vpc   = true

  tags = merge(var.tags, {
    Name = format("%s-%s-%s-eip-%d-%s", var.tags["id"], var.tags["environment"], var.tags["project"], count.index + 1, element(var.availability_zone, count.index))
  })
  depends_on = [aws_internet_gateway.vincent_igw]
}