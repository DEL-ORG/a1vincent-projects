resource "aws_internet_gateway" "vincent_igw" {
  vpc_id = aws_vpc.vincent_vpc.id

  tags = merge(var.tags, {
    Name = format("%s-practice_igw", var.tags["id"])
    }
  )
}