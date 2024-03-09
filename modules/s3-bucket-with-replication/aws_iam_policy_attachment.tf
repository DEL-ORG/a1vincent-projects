# # IAM Policy Attachment
# resource "aws_iam_policy_attachment" "replication" {
#   provider   = aws.main
#   name       = format("%s-%s-s3-replication-policy-attachment", var.tags["id"], var.tags["project"])
#   roles      = [aws_iam_role.replication_role.name]
#   policy_arn = aws_iam_policy.replication_policy.arn
# }

resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}

