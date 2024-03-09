# # IAM Role for Replication
# resource "aws_iam_role" "replication" {
#   provider = aws.main
#   name     = format("%s-%s-s3-replication-role", var.tags["id"], var.tags["project"])
#   assume_role_policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [{
#       "Effect" : "Allow",
#       "Principal" : {
#         "Service" : "s3.amazonaws.com"
#       },
#       "Action" : "sts:AssumeRole"
#     }]
#   })

#   tags = var.tags
# }

resource "aws_iam_role" "replication" {
  # name               = "tf-iam-role-replication-12345"
  name               = format("%s-%s-s3-role-replication", var.tags["id"], var.tags["project"])
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

