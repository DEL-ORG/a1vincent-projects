variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "tags" {
  type = map(any)
  default = {
    "id"             = "2024"
    "owner"          = "a1vincent"
    "teams"          = "practical"
    "environment"    = "dev"
    "project"        = "postgres"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "instance_class" {
  type    = string
  default = "db.r5g.large"
}


variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-0485c796b520799ed", "subnet-04744e1271ed24369"]
}

variable "availability_zones" {
  type    = list(any)
  default = ["us-east-1b", "us-east-1b", "us-east-1d"]
}

variable "cluster_family" {
  type    = string
  default = "aurora-postgresql11"
}

variable "engine" {
  type    = string
  default = "aurora-postgresql"
}

variable "engine_version" {
  type    = string
  default = "11.9"
}

variable "database_name" {
  type    = string
  default = "aurora-cluster-prosgresql"
}

variable "storage_encrypted" {
  type    = bool
  default = true
}

variable "backup_retention_period" {
  type    = string
  default = "7"
}

variable "preferred_backup_window" {
  type    = string
  default = "07:00-09:00"
}

variable "deletion_protection" {
  type    = bool
  default = false
}

variable "count" {
  type    = string
  default = "2"
}

variable "instance_class" {
  type    = string
  default = "db.r5.large"
}

variable "publicly_accessible" {
  type    = bool
  default = false
}