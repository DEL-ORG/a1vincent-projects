resource "aws_rds_cluster_parameter_group" "a1vincent_parameter_group" {
  name        = "a1vincent-rds-cluster-parameter-group"
  family      = "aurora-postgresql11"
  description = "RDS default cluster parameter group"

  # parameter {
  #   name  = "character_set_server"
  #   value = "utf8"
  # }

  # parameter {
  #   name  = "log_connections"
  #   value = "1"
  # }

  # lifecycle {
  #   create_before_destroy = true
  # }
}