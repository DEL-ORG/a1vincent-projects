resource "aws_vpc" "vincent_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(var.tags, {
    Name = format("%s-%s-%s-vpc", var.tags["id"], var.tags["environment"], var.tags["project"])
  })
}
