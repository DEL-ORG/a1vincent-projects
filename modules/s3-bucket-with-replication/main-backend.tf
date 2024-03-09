resource "aws_s3_bucket" "main-backend" {
  provider = aws.main
  bucket   = format("%s-%s-main-backend", var.tags["id"], var.tags["project"])

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "main-backend" {
  provider = aws.main
  bucket   = aws_s3_bucket.main-backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

# resource "aws_s3_bucket" "source" {
#   provider = aws.central
#   bucket   = "tf-test-bucket-source-12345"
# }

# resource "aws_s3_bucket_acl" "source_bucket_acl" {
#   provider = aws.central
#   bucket   = aws_s3_bucket.source.id
#   acl      = "private"
# }

# resource "aws_s3_bucket_versioning" "source" {
#   provider = aws.central
#   bucket   = aws_s3_bucket.source.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }