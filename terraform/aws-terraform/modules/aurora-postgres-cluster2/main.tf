terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

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

resource "aws_db_subnet_group" "a1vincent_subnet_group" {
  name       = "a1vincent_subnet_group"
  subnet_ids = var.subnet_ids

  tags = merge(var.tags, {
    Name = format("%s-rds-subnet-group", var.tags["owner"])
  })
}

terraform {
  backend "s3" {
    bucket         = "2024-dev-tf-state"
    dynamodb_table = "2024 - dev-tf-state-lock"
    key            = "postgres"
    region         = "us-east-1"
  }
}

# Generate a random suffix to ensure unique resource names
resource "random_id" "kms_suffix" {
  byte_length = 4
}

# Create a KMS key
resource "aws_kms_key" "a1vincent_key" {
  description             = "Example KMS Key"
  deletion_window_in_days = 7
  tags = {
    Name = "a1vincentKMSKey-${random_id.kms_suffix.hex}"
  }
}

# Create a Secrets Manager secret with the KMS key
resource "aws_secretsmanager_secret" "a1vincent_secret" {
  name        = "a1vincent_secret-${random_id.kms_suffix.hex}"
  description = "Example Secret"
  kms_key_id  = aws_kms_key.a1vincent_key.id

  tags = {
    Environment = "Development"
  }
}

resource "aws_security_group" "a1vincent_rds_sg" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_route53_record" "cluster-alias" {
#   count = length(aws_rds_cluster_instance.cluster_instances)

#   zone_id = "Z09063052B43KCQ7FSGHY"
#   name    = "artifactory-${count.index}"
#   type    = "CNAME"
#   ttl     = "30"

#   records = [aws_rds_cluster_instance.cluster_instances[count.index].endpoint]
# }

resource "aws_route53_record" "cluster-alias" {
  zone_id = "Z09063052B43KCQ7FSGHY"
  name    = "artifactory"
  type    = "CNAME"
  ttl     = "30"
  records = [aws_rds_cluster.aurora-cluster.endpoint]
}
