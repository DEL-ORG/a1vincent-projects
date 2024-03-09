resource "aws_iam_policy" "replication" {
  # name   = "tf-iam-role-policy-replication-12345"
  name   = format("%s-%s-s3-role-policy-replication", var.tags["id"], var.tags["project"])
  policy = data.aws_iam_policy_document.replication.json
}

data "aws_iam_policy_document" "replication" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
    ]

    resources = [aws_s3_bucket.main-backend.arn]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
      "s3:PutBucketVersioning",
    ]

    resources = ["${aws_s3_bucket.main-backend.arn}/*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
    ]

    resources = ["${aws_s3_bucket.backup-backend.arn}/*"]
  }
}



# resource "aws_iam_policy" "s3_versioning_policy" {
#   name        = format("%s-%s-s3-versioning-policy", var.tags["id"], var.tags["project"])
#   description = "Allows enabling versioning on S3 buckets"
#   policy      = data.aws_iam_policy_document.s3_versioning_policy.json
# }

# data "aws_iam_policy_document" "s3_versioning_policy" {
#   statement {
#     actions   = ["s3:PutBucketVersioning"]
#     resources = [aws_s3_bucket.backup-backend.arn]
#   }
# }

# # IAM Policy for Replication
# resource "aws_iam_policy" "replication" {
#   provider = aws.main
#   name     = format("%s-%s-s3-replication-policy", var.tags["id"], var.tags["project"])
#   policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [{
#       "Effect" : "Allow",
#       "Action" : [
#         "s3:GetReplicationConfiguration",
#         "s3:ListBucket"
#       ],
#       "Resource" : "${aws_s3_bucket.main-backend.arn}/*"
#     }]
#   })
# }
