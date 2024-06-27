resource "aws_secretsmanager_secret_rotation" "a1vincent_secret-rotate" {
  secret_id           = aws_secretsmanager_secret.a1vincent_secret.id
  rotation_lambda_arn = aws_lambda_function.test_lambda.arn

  rotation_rules {
    automatically_after_days = var.rotation-window
  }
}

resource "aws_secretsmanager_secret_rotation" "example" {
  secret_id           = aws_secretsmanager_secret.example.id
  rotation_lambda_arn = aws_lambda_function.example.arn

  rotation_rules {
    automatically_after_days = var.rotation-window
  }
}




