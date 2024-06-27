resource "aws_rds_cluster_parameter_group" "a1vincent_parameter_group" {
  name        = format("%s-%s-%s-cluster-parameter-group", var.tags["id"], var.tags["environment"], var.tags["project"])
  family      = var.cluster_family
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