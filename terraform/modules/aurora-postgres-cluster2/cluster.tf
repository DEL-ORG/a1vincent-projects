resource "aws_rds_cluster" "a1vincent_postgresql_cluster" {
  cluster_identifier              = format("%s-%s-%s-aurora-cluster-prosgresql", var.tags["id"], var.tags["environment"], var.tags["project"])
  engine                          = var.engine
  engine_version                  = var.engine_version
  availability_zones              = var.availability_zones
  database_name                   = var.database_name
  master_username                 = data.aws_secretsmanager_secret_version.rds_username.secret_string
  master_password                 = data.aws_secretsmanager_secret_version.rds_password.secret_string
  backup_retention_period         = var.backup_retention_period
  preferred_backup_window         = var.preferred_backup_window
  deletion_protection             = false
  storage_encrypted               = var.storage_encrypted
  vpc_security_group_ids          = [aws_security_group.a1vincent_rds_sg.id]
  db_subnet_group_name            = aws_db_subnet_group.a1vincent_subnet_group.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.a1vincent_parameter_group.name
  skip_final_snapshot             = true # Set to false if you want to take a final snapshot when deleting the cluster

  lifecycle {
    ignore_changes = [
      engine_version
    ]
  }

  tags = merge(var.tags, {
    Name = format("%s-%s-%s-aurora-cluster-prosgresql", var.tags["id"], var.tags["environment"], var.tags["project"])
  })
}