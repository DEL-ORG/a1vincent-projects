# resource "aws_route53_record" "cluster-alias" {
#   zone_id = "Z09063052B43KCQ7FSGHY"
#   name    = var.database_name
#   type    = "CNAME"
#   ttl     = "30"
#   #   records = [aws_db_instance.alpha-db.endpoint]
#   records = [aws_rds_cluster.aurora-cluster.endpoint]
# }