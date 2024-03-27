# Create a secret in AWS Secrets Manager dynamically
resource "aws_secretsmanager_secret" "example_secret" {
  name        = "example-secret"
  description = "Example secret created dynamically with Terraform"
}

# Store the secret value "practical-devops" in the secret
resource "aws_secretsmanager_secret_version" "example_secret_version" {
  secret_id     = aws_secretsmanager_secret.example_secret.id
  secret_string = "practical-devops"
}

# Create IAM policy for Lambda to access Secrets Manager
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda-secret-policy"
  description = "IAM policy for Lambda to access Secrets Manager"
  policy      = data.aws_iam_policy_document.lambda_policy.json
}

# Define IAM policy document for Lambda policy
data "aws_iam_policy_document" "lambda_policy" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:PutSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:UpdateSecret",
      "secretsmanager:ListSecretVersionIds",
    ]

    resources = [aws_secretsmanager_secret.example_secret.arn]

    effect = "Allow"
  }
}

# Create IAM role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda-secret-rotation-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach policy to Lambda role
resource "aws_iam_role_policy_attachment" "lambda_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Update Lambda function for secret rotation
resource "aws_lambda_function" "secret_rotation_function" {
  function_name    = "secret-rotation-function"
  handler          = "index.handler"
  runtime          = "nodejs16.x"
  role             = aws_iam_role.lambda_role.arn
  filename         = "lambda_function_payload.zip" # Specify the path to your Lambda function code
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
}

# Grant Secrets Manager permission to invoke the Lambda function
resource "aws_lambda_permission" "allow_secretsmanager_invoke" {
  statement_id  = "AllowExecutionFromSecretsManager"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.secret_rotation_function.arn
  principal     = "secretsmanager.amazonaws.com"
}


# Schedule rotation for the secret
resource "aws_secretsmanager_secret_rotation" "example_secret_rotation" {
  secret_id           = aws_secretsmanager_secret.example_secret.id
  rotation_lambda_arn = aws_lambda_function.secret_rotation_function.arn
  rotation_rules {
    automatically_after_days = 30 # Rotate the secret automatically after 30 days
  }
}


