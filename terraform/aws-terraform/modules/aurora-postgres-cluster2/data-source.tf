data "aws_vpc" "vpc_id" {
  filter {
    name   = "tag:Name"
    values = format("%s-%s-%s-vpc", var.tags["id"], var.tags["environment"], var.tags["project"])
  }
}

data "aws_subnet" "private_subnet_01" {
  filter {
    name   = "tag:Name"
    values = ["2024-dev-postgres-private-subnet-1-us-east-1a"]
  }
}

data "aws_subnet" "private_subnet_02" {
  filter {
    name   = "tag:Name"
    values = ["2024-dev-postgres-private-subnet-2-us-east-1b"]
  }
}

# Get secret information for RDS password
data "aws_secretsmanager_secret" "rds_password" {
  name = "2024-dev-postgres-aurora-cluster-prosgresql-db-password"
}

data "aws_secretsmanager_secret_version" "rds_password" {
  secret_id = data.aws_secretsmanager_secret.rds_password.id
}

# Get secret information for RDS username
data "aws_secretsmanager_secret" "rds_username" {
  name = "2024-dev-postgres-aurora-cluster-prosgresql-db-username"
}

data "aws_secretsmanager_secret_version" "rds_username" {
  secret_id = data.aws_secretsmanager_secret.rds_username.id
}

# ## CREATE A DATABASE WITH USERNAME AND PASSWORD
# password = data.aws_secretsmanager_secret_version.rds_password.secret_string
# username = data.aws_secretsmanager_secret_version.rds_username.secret_string
