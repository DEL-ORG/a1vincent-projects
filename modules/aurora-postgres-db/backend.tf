terraform {
  backend "s3" {
    bucket = "terraform-ericvincent"
    #dynamodb_table = var.backend["dynamodb_table"]
    key    = "DevOps"
    region = "us-east-1"
  }
}