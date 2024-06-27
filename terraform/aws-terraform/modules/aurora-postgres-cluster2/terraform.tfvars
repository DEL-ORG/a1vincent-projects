aws_region = "us-east-1"

vpc_id             = "vpc-030e24dca629c0007"
subnet_ids         = ["subnet-0485c796b520799ed", "subnet-04744e1271ed24369"]
availability_zones = ["us-east-1b", "us-east-1b", "us-east-1d"]

tags = {
  "id"             = "2024"
  "owner"          = "a1vincent"
  "teams"          = "practical"
  "environment"    = "dev"
  "project"        = "postgres"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}

cluster_family          = "aurora-postgresql11"
engine                  = "aurora-postgresql"
engine_version          = "11.9"
instance_class          = "db.r5g.large"
database_name           = "aurora-cluster-prosgresql"
storage_encrypted       = true
backup_retention_period = "7"
preferred_backup_window = "07:00-09:00"
deletion_protection     = false
count                   = "2"
publicly_accessible     = false
