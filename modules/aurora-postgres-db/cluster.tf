resource "aws_rds_cluster" "a1vincent_postgresql_cluster" {
  cluster_identifier = "aurora-cluster-prosgresql"
  engine             = "aurora-postgresql"
  engine_version     = "11"
  availability_zones = var.availability_zones
  database_name      = "a1vincent_db"
  # master_username                 = "adminuser"
  # master_password                 = var.db_master_password # Use input variable here
  backup_retention_period         = 0
  preferred_backup_window         = "07:00-09:00"
  deletion_protection             = false
  storage_encrypted               = true
  vpc_security_group_ids          = [aws_security_group.a1vincent_rds_sg.id]
  db_subnet_group_name            = aws_db_subnet_group.a1vincent_subnet_group.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.a1vincent_parameter_group.name
  skip_final_snapshot             = true

  lifecycle {
    ignore_changes = [
      engine_version
    ]
  }

  tags = merge(var.tags, {
    Name = format("%s-rds-cluster", var.tags["owner"])
  })
}