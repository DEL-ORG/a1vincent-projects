resource "aws_rds_cluster_instance" "a1vincent_instance" {
  count                = 2
  identifier           = "a1vincent-rds-instance-${count.index + 1}"
  cluster_identifier   = aws_rds_cluster.a1vincent_postgresql_cluster.id
  instance_class       = "db.r5.large"
  engine               = aws_rds_cluster.a1vincent_postgresql_cluster.engine
  engine_version       = aws_rds_cluster.a1vincent_postgresql_cluster.engine_version
  db_subnet_group_name = aws_db_subnet_group.a1vincent_subnet_group.name
  publicly_accessible  = true


  lifecycle {
    ignore_changes = [
      engine_version
    ]
  }
  tags = merge(var.tags, {
    Name = "cluster-instance-${count.index + 1}"
  })
}