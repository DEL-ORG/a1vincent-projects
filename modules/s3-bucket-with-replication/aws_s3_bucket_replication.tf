resource "aws_s3_bucket_replication_configuration" "replication" {
  provider = aws.main
  # Must have bucket versioning enabled first
  depends_on = [
    aws_s3_bucket_versioning.main-backend,
    aws_s3_bucket_versioning.backup-backend
  ]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.main-backend.id

  rule {
    id = "StateReplicationAll"

    filter {
      prefix = ""
    }

    status = "Enabled"


    destination {
      bucket        = aws_s3_bucket.backup-backend.arn
      storage_class = "STANDARD"
    }
    # source_selection_criteria {
    #   sse_kms_encrypted_objects {
    #     status = "Disabled"
    #   }
    # }

    delete_marker_replication {
      status = "Enabled"
    }
  }
}









