resource "aws_secretsmanager_secret_version" "a1vincent_secret-version" {
  secret_id = aws_secretsmanager_secret.a1vincent_secret.id
  # secret_string = "Pratical"
  secret_string = "2024-a1vincent-secret"
}

#Secrets Manager also accepts key-value pairs in JSON.
# The map here can come from other supported configurations
# like locals, resource attribute, map() built-in, etc.
# variable "example" {
#   default = {
#     key1 = "value1"
#     key2 = "value2"
#   }

#   type = map(string)
# }

# resource "aws_secretsmanager_secret_version" "example" {
#   secret_id     = aws_secretsmanager_secret.example.id
#   secret_string = jsonencode(var.example)
# }