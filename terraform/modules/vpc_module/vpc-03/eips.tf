# Create Elastic IPs
resource "aws_eip" "vincent_eip" {
  count = local.num_nat_gateways
  vpc   = true
  # domain = "vpc"

  tags = merge(var.tags, {
    Name = format("%s-%s-eip", var.tags["id"], var.tags["project"])
  })
  depends_on = [aws_internet_gateway.vincent_igw]
}



