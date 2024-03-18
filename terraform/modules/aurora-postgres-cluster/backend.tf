terraform {
  backend "s3" {
    bucket         = "2024-dev-tf-state"
    dynamodb_table = "2024 - dev-tf-state-lock"
    key            = "postgres"
    region         = "us-east-1"
  }
}