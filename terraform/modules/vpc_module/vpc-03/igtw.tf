resource "aws_internet_gateway" "vincent_igw" {
  depends_on = [aws_vpc.vincent_vpc]
  vpc_id     = aws_vpc.vincent_vpc.id

  tags = merge(var.tags, {
    Name = format("%s-vincent_igw", var.tags["id"])
    }
  )
}




