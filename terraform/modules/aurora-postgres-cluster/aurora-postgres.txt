# how to avoid exposing password in RDS database (aurora postgres)
master_password                 = var.db_master_password  # Use input variable here

variable "db_master_password" {
  description = "The master password for the RDS cluster"
  type        = string
  sensitive   = true
  # You can set a default value if needed
  # default     = "defaultpassword"
}
# For example, you can set it via command-line flags:
terraform apply -var 'db_master_password=mysecurepassword'

# Or, you can set it via environment variables:
export TF_VAR_db_master_password=password
terraform apply

# You can also use AWS Secrets Manager:
Here's how you can retrieve the master password for your RDS cluster from AWS Secrets Manager:

data "aws_secretsmanager_secret" "rds_master_password" {
  name = "your/secret/name"  # Replace with the name of your secret in AWS Secrets Manager
}

master_password                 = data.aws_secretsmanager_secret.rds_master_password.secret_string

# or AWS Systems Manager Parameter Store:
Here's how you can retrieve the master password for your RDS cluster from AWS Systems Manager Parameter Store:

data "aws_ssm_parameter" "rds_master_password" {
  name = "/your/parameter/name"  # Replace with the name of your parameter in Systems Manager Parameter Store
}

master_password                 = data.aws_ssm_parameter.rds_master_password.value


# Terraform configuration

data "aws_secretsmanager_secret" "rds_master_password" {
  name = "your/secret/name"  # Replace with the name of your secret in AWS Secrets Manager
}

resource "aws_rds_cluster" "a1vincent_postgresql_cluster" {
  ...
  master_password = data.aws_secretsmanager_secret.rds_master_password.secret_string
  ...
}

