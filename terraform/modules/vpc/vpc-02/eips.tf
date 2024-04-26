resource "aws_eip" "vincent_eip" {
  # count = length(var.availability_zone)
  vpc = true

  tags = merge(var.tags, {
    Name = format("%s-%s-%s-eip", var.tags["id"], var.tags["environment"], var.tags["project"])

    depends_on = "aws_internet_gateway.vincent_igw"
  })

}