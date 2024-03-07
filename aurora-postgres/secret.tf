# Generate a random suffix to ensure unique resource names
resource "random_id" "kms_suffix" {
  byte_length = 4
}

# Create a KMS key
resource "aws_kms_key" "a1vincent_key" {
  description             = "Example KMS Key"
  deletion_window_in_days = 7
  tags = {
    Name = "a1vincentKMSKey-${random_id.kms_suffix.hex}"
  }
}

# Create a Secrets Manager secret with the KMS key
resource "aws_secretsmanager_secret" "a1vincent_secret" {
  name        = "a1vincent_secret-${random_id.kms_suffix.hex}"
  description = "Example Secret"
  kms_key_id  = aws_kms_key.a1vincent_key.id

  tags = {
    Environment = "Development"
  }
}

