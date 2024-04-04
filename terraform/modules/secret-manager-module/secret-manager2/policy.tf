data "aws_iam_policy_document" "secret_iam_policy" {
  statement {
    sid    = "EnableAnotherAWSAccountToReadTheSecret"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"] # Correcting the ARN to include "role/"
    }

    actions   = ["secretsmanager:GetSecretValue"]
    resources = ["*"]
  }
}

resource "aws_secretsmanager_secret_policy" "a1vincent_secret_policy" {
  secret_arn = aws_secretsmanager_secret.a1vincent_secret.arn
  policy     = data.aws_iam_policy_document.secret_iam_policy.json
}

resource "aws_secretsmanager_secret" "example" {
  name = "example"
}

data "aws_iam_policy_document" "example" {
  statement {
    sid    = "EnableAnotherAWSAccountToReadTheSecret"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::123456789012:root"]
    }

    actions   = ["secretsmanager:GetSecretValue"]
    resources = ["*"]
  }
}

resource "aws_secretsmanager_secret_policy" "example" {
  secret_arn = aws_secretsmanager_secret.example.arn
  policy     = data.aws_iam_policy_document.example.json
}