# Determine the number of NAT Gateways based on environment
locals {
  num_nat_gateways = var.environment == "dev" ? 1 : length(var.availability_zones)
}

resource "aws_nat_gateway" "vincent_nat_gateway" {
  count         = local.num_nat_gateways
  subnet_id     = aws_subnet.vincent_public_subnet[count.index].id
  allocation_id = aws_eip.vincent_eip[count.index].id

  tags = merge(var.tags, {
    Name = format("%s-%s-vincent_nat_gateway", var.tags["id"], var.tags["project"])
  })
}


