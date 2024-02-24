resource "aws_s3_bucket" "vincent_s3_backend" {
  bucket = format("%s-%s-${random_string.vincent_random_s3.result}-statefile", var.tags["id"], var.tags["environment"])

  tags = var.tags
}


resource "random_string" "vincent_random_s3" {
  length  = 5
  special = var.random_s3["special"]
  upper   = var.random_s3["upper"]
  numeric = var.random_s3["numeric"]
}

resource "aws_s3_bucket_versioning" "vincent_s3_versioning" {
  bucket = aws_s3_bucket.vincent_s3_backend.id
  versioning_configuration {
    status = var.s3_versioning
  }
}

resource "aws_dynamodb_table" "vincent_dynamodb" {
  name           = format("dynamodb-${random_string.vincent_random_s3.result}-%s-%s", var.tags["id"], var.tags["environment"])
  hash_key       = "BEWARE"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "BEWARE"
    type = "S"
  }

}