resource "aws_db_subnet_group" "a1vincent_subnet_group" {
  name = format("%s-%s-%s-db-subnet-group", var.tags["id"], var.tags["environment"], var.tags["project"])
  subnet_ids = [
    data.aws_subnet.private_subnet_01.id,
    data.aws_subnet.private_subnet_02.id
  ]

  tags = merge(var.tags, {
    Name = format("%s-rds-subnet-group", var.tags["id"])
  })
}