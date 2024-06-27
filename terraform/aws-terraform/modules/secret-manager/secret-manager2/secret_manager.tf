resource "aws_secretsmanager_secret" "a1vincent_secret" {
  name                    = format("%s-a1vincent-secret", var.common_tags["project"])
  recovery_window_in_days = 0
  tags = merge(var.tags, {
    Name = format("%s-a1vincent-secret", var.tags["id"])
  })
}

