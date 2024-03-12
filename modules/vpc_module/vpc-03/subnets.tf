resource "aws_subnet" "vincent_private_subnet" {
  count             = length(var.availability_zone)
  vpc_id            = aws_vpc.vincent_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, count.index * 4)
  availability_zone = element(var.availability_zone, count.index)

  tags = merge(var.tags, {
    Name = format("%s-vincent_private_subnet-${count.index}", var.tags["id"])
  })
}

resource "aws_subnet" "vincent_public_subnet" {
  count                   = length(var.availability_zone)
  vpc_id                  = aws_vpc.vincent_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 4, count.index * 4 + 1)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = format("%s-vincent_public_subnet-${count.index}", var.tags["id"])
  })
}
