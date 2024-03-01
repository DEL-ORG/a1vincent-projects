aws_region = "us-east-1"

vpc_id             = "vpc-030e24dca629c0007"
subnet_ids         = ["subnet-0485c796b520799ed", "subnet-04744e1271ed24369"]
availability_zones = ["us-east-1b", "us-east-1d"]

tags = {
  "id"             = "2024"
  "owner"          = "a1vincent"
  "teams"          = "practical"
  "environment"    = "dev"
  "project"        = "rds-postgres"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}


instance_class = "db.r5g.large"