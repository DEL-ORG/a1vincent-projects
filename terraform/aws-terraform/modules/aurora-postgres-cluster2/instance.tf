resource "aws_rds_cluster_instance" "a1vincent_instance" {
  count                = var.count
  identifier           = "${var.database_name}-${count.index + 1}"
  cluster_identifier   = aws_rds_cluster.a1vincent_postgresql_cluster.id
  instance_class       = var.instance_class
  engine               = "aurora-postgresql"
  engine_version       = "11.9"
  db_subnet_group_name = aws_db_subnet_group.a1vincent_subnet_group.name
  publicly_accessible  = var.publicly_accessible


  lifecycle {
    ignore_changes = [
      engine_version
    ]
  }
  tags = merge(var.tags, {
    Name = "${var.database_name}-${count.index + 1}"
  })
}